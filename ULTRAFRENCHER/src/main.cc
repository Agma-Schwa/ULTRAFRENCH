#include <csignal>
#include <inflect.hh>
#include <iostream>
#include <span>
#include <SQLiteCpp/SQLiteCpp.h>
#include <utils.hh>
#include <vector>
#include <word.hh>

#define COMMAND(name) void name(std::vector<std::string>&& args)

/// For easy access.
std::unique_ptr<SQLite::Database> db;

/// Set up the database.
void init_db() try {
    db = std::make_unique<SQLite::Database>("dictionary.sqlite", SQLite::OPEN_READWRITE | SQLite::OPEN_CREATE);
    db->exec(R"sql(
        CREATE TABLE IF NOT EXISTS words (
            word TEXT PRIMARY KEY,
            part_of_speech TEXT,
            comment TEXT,
            etymology TEXT,
            future_stem TEXT,
            subjunctive_stem TEXT
        ) STRICT
    )sql");
    db->exec(R"sql(
        CREATE TABLE IF NOT EXISTS definitions (
            word TEXT REFERENCES words(word),
            definition TEXT,
            UNIQUE(word, definition)
        ) STRICT
    )sql");
} catch (const std::exception& e) {
    die("Failed to initialise database: {}", e.what());
}

/// Add a word to the database.
COMMAND (add_word) {
    /// Must have at least one arg and at most six.
    if (args.empty() or args.size() > 6) {
        fmt::print("Incorrect number of arguments. See `help a` for usage.\n");
        return;
    }

    /// Normalise the word.
    args[0] = word{args[0]}.string();

    /// Check if the word already exists.
    SQLite::Statement stmt(*db, "SELECT 1 FROM words WHERE word = ?");
    stmt.bind(1, args[0]);
    if (stmt.executeStep()) {
        fmt::print("Word '{}' already exists.\n", args[0]);
        return;
    }

    /// Add the word.
    SQLite::Statement stmt2(*db, "INSERT INTO words VALUES (?, ?, ?, ?, ?, ?)");
    stmt2.bind(1, args[0]);

    /// Bind the other args.
    if (args.size() >= 2) stmt2.bind(2, args[1]);                /// Part of speech.
    if (args.size() >= 3) stmt2.bind(3, args[2]);                /// Comment.
    if (args.size() >= 4) stmt2.bind(4, args[3]);                /// Etymology.
    if (args.size() >= 5) stmt2.bind(5, word{args[4]}.string()); /// Future stem.
    if (args.size() >= 6) stmt2.bind(6, word{args[5]}.string()); /// Subjunctive stem.

    /// Execute the statement.
    stmt2.exec();
}

/// Add a definition to a word.
COMMAND (add_definition) {
    /// Must have two args.
    if (args.size() != 2) {
        fmt::print("Incorrect number of arguments. See `help d` for usage.\n");
        return;
    }

    /// Normalise the word.
    args[0] = word{args[0]}.string();

    /// Check if the word exists.
    SQLite::Statement stmt(*db, "SELECT 1 FROM words WHERE word = ?");
    stmt.bind(1, args[0]);
    if (not stmt.executeStep()) {
        fmt::print("Word '{}' does not exist.\n", args[0]);
        return;
    }

    /// Add the definition.
    SQLite::Statement stmt2(*db, "INSERT OR IGNORE INTO definitions VALUES (?, ?)");
    stmt2.bind(1, args[0]);
    stmt2.bind(2, args[1]);

    /// Execute the statement.
    stmt2.exec();
}

/// List all words in the database.
COMMAND (list_words) {
    if (args.size() > 1) {
        fmt::print("Incorrect number of arguments. See `help l` for usage.\n");
        return;
    }

    /// Normalise the word.
    if (args.size() == 1) args[0] = word{args[0]}.string();

    /// Get all words.
    std::string query_string = "SELECT * FROM words ORDER BY word";
    if (args.size() == 1) query_string = "SELECT * FROM words WHERE word LIKE ? || '%' ORDER BY word ASC";
    SQLite::Statement stmt(*db, query_string);
    if (args.size() == 1) stmt.bind(1, args[0]);

    /// Select all words.
    while (stmt.executeStep()) {
        fmt::print("\033[33m{}\033[32m", stmt.getColumn(0).getText());
        if (not stmt.isColumnNull(1)) fmt::print(" {}", stmt.getColumn(1).getText());
        if (not stmt.isColumnNull(2)) fmt::print(" {}", stmt.getColumn(2).getText());
        if (not stmt.isColumnNull(3)) fmt::print(" [{}]", stmt.getColumn(3).getText());
        if (not stmt.isColumnNull(4)) fmt::print(" F: {}", stmt.getColumn(4).getText());
        if (not stmt.isColumnNull(5)) fmt::print(" S: {}", stmt.getColumn(5).getText());
        fmt::print("\033[m\n");

        /// Select all definitions for the word.
        SQLite::Statement stmt2(*db, "SELECT definition FROM definitions WHERE word = ? ORDER BY definition ASC");
        usz i = 1;
        stmt2.bind(1, stmt.getColumn(0).getText());
        while (stmt2.executeStep()) fmt::print("    \033[34m{:>2}. {}\033[m\n", i++, stmt2.getColumn(0).getText());
    }
}

COMMAND (delete_word) {
    /// Must have one arg.
    if (args.size() != 1) {
        fmt::print("Incorrect number of arguments. See `help d` for usage.\n");
        return;
    }

    /// Normalise the word.
    args[0] = word{args[0]}.string();

    /// Delete the word.
    SQLite::Statement stmt2(*db, "DELETE FROM words WHERE word = ?");
    stmt2.bind(1, args[0]);
    if (stmt2.exec()) fmt::print("Deleted word '{}'.\n", args[0]);
    else fmt::print("Word '{}' does not exist.\n", args[0]);
}

/// Inflect an UF word.
COMMAND (inflect) {
    /// Get word.
    if (args.size() < 2) {
        fmt::print("Usage: i <word> <person> [voice] [tense] [mood]\n");
        return;
    }

    /// Normalise the word.
    args[0] = word{args[0]}.string();

    /// Check if the word exists.
    SQLite::Statement stmt(*db, "SELECT * FROM words WHERE word = ?");
    stmt.bind(1, args[0]);
    if (not stmt.executeStep()) {
        fmt::print("Word '{}' does not exist.\n", args[0]);
        return;
    }

    /// Get word data.
    std::string_view part_of_speech = stmt.getColumn(1).getText();

    /// Inflect the word.
    if (part_of_speech == "v.") {
        std::string_view future_stem = stmt.getColumn(4).getText();
        std::string_view subjunctive_stem = stmt.getColumn(5).getText();
        auto res = inflect_verb(args[0], future_stem, subjunctive_stem, std::span{args}.subspan(1));
        if (res) fmt::print("{}\n", *res);
    } else {
        fmt::print("Sorry, don’t know how to inflect word w/ part of speech '{}'.\n", part_of_speech);
        return;
    }
}

COMMAND (print_help) {
    /// Takes at most one arg.
    if (args.size() > 1) {
        fmt::print("Usage: help [command]\n");
        return;
    }

    /// Print help for a specific command.
    if (not args.empty()) {
        if (args[0] == "a") {
            fmt::print(
                "Command `a`: Add a word to the dictionary.\n"
                "Usage:\n"
                "    a <word> [part of speech] [comment]\n"
                "            [etymology] [future stem]\n"
                "            [subjunctive stem]\n"
            );
        } else if (args[0] == "d") {
            fmt::print(
                "Command `d`: Add a definition to a word.\n"
                "Usage:\n"
                "    d <word> <definition>\n"
            );
        } else if (args[0] == "l") {
            fmt::print(
                "Command `l`: List all words in the dictionary. If the `letters`\n"
                "    argument is provided, only words starting with those letters\n"
                "    will be listed.\n"
                "Usage:\n"
                "    l [letters]\n"
            );
        } else if (args[0] == "i") {
            fmt::print(
                "Command `i`: Inflect a word.\n"
                "Usage:\n"
                "    i <word> <person> [voice] [tense] [mood]\n"
            );
        } else if (args[0] == "u") {
            fmt::print(
                "Command `u`: Update a word.\n"
                "Usage:\n"
                "    u <word> [part of speech] [comment]\n"
                "            [etymology] [future stem]\n"
                "            [subjunctive stem]\n"
            );
        } else if (args[0] == "help") {
            fmt::print(
                "Command `help`: Print help information about a command or all commands.\n"
                "Usage:\n"
                "    help [command]\n"
            );
        } else if (args[0] == "q") {
            fmt::print(
                "Command `q`: Quit the program.\n"
                "Usage:\n"
                "    q\n"
            );
        } else if (args[0] == "x") {
            fmt::print(
                "Command `x`: Delete a word.\n"
                "Usage:\n"
                "    x <word>\n"
            );
        } else fmt::print("Unknown command: {}. Run `help` for a list of all commands.\n", args[0]);
        return;
    }

    /// Default message.
    fmt::print(
        "Commands:\n"
        "    \033[33ma       \033[32mAdd a word\n"
        "    \033[33md       \033[32mAdd a definition to a word\n"
        "    \033[33mi       \033[32mInflect a word\n"
        "    \033[33ml       \033[32mList all words\n"
        "    \033[33mhelp    \033[32mPrint this help message\n"
        "    \033[33mq       \033[32mQuit\n"
        "    \033[33mu       \033[32mUpdate a word\n"
        "    \033[33mx       \033[32mDelete a word\n"
        "\033[m"
    );
}

void dispatch_command(std::string_view line) {
    /// Split command by spaces, discarding consecutive ones. Respect
    /// single-quoted and double-quoted arguments.
    std::string command;
    std::vector<std::string> args;
    bool in_single_quotes = false;
    bool in_double_quotes = false;
    std::string* append_to = &command;
    for (char c : line) {
        switch (c) {
            case '\'': {
                if (in_double_quotes) goto default_;
                in_single_quotes = not in_single_quotes;
            } break;

            case '"': {
                if (in_single_quotes) goto default_;
                in_double_quotes = not in_double_quotes;
            } break;

            case ' ': {
                if (in_single_quotes or in_double_quotes) goto default_;
                append_to = &args.emplace_back();
            } break;

            default:
            default_:
                append_to->push_back(c);
                break;
        }
    }

    /// Make sure we don’t have any dangling quotes.
    if (in_single_quotes or in_double_quotes) {
        fmt::print(
            "Unpaired quote. Try using typographic quotes ’ or surrounding\n"
            "the argument containing the quote with single or double quotes.\n"
        );
        return;
    }

    /// Replace typographic quotes with regular ones.
    for (auto& arg : args) {
        for (;;) {
            auto pos = arg.find("’");
            if (pos == std::string::npos) break;
            arg.replace(pos, sizeof("’") - 1, "'");
        }
    }

    /// Handle the command.
    if (command == "a") add_word(std::move(args));
    else if (command == "d") add_definition(std::move(args));
    else if (command == "l") list_words(std::move(args));
    else if (command == "i") inflect(std::move(args));
    else if (command == "help") print_help(std::move(args));
    else if (command == "q") std::exit(0);
    else if (command == "x") delete_word(std::move(args));
    else fmt::print("Unknown command: {}. Run `help` for a list of all commands.\n", command);
}

int main() {
    init_db();

    /// Ignore sigint.
    signal(SIGINT, SIG_IGN);

    /// REPL main loop.
    for (;;) {
        if (std::cin.eof()) break;
        fmt::print("\033[1;32mɮ\033[m ");
        std::string line;
        std::getline(std::cin, line);
        if (line.empty()) continue;

        try {
            dispatch_command(line);
        } catch (const std::exception& e) {
            fmt::print("Error: {}\n", e.what());
        }
    }
}
