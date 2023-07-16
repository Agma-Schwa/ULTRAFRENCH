#include <csignal>
#include <iostream>
#include <SQLiteCpp/SQLiteCpp.h>
#include <utils.hh>
#include <vector>

#define COMMAND(name) void name(std::vector<std::string>&& args)

/// For easy access.
std::unique_ptr<SQLite::Database> db;

/// Set up the database.
void init_db() try {
    db = std::make_unique<SQLite::Database>("dictionary.sqlite", SQLite::OPEN_READWRITE | SQLite::OPEN_CREATE);
    db->exec(R"sql(
        CREATE TABLE IF NOT EXISTS words (
            word TEXT PRIMARY KEY,
            etymology TEXT,
            part_of_speech TEXT,
            comment TEXT,
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
        fmt::print("Usage: a <word> [part of speech] [comment] [etymology] [future stem] [subjunctive stem]\n");
        return;
    }

    /// Check if the word already exists.
    SQLite::Statement stmt(*db, "SELECT 1 FROM words WHERE word = ?");
    stmt.bind(1, args[0]);
    if (stmt.executeStep()) {
        fmt::print("Word '{}' already exists.\n", args[0]);
        return;
    }

    /// Add the word.
    SQLite::Statement stmt2(*db, "INSERT INTO words VALUES (?, ?, ?, ?, ?, ?)");
    usz i = 1;
    stmt2.bind(1, args[0]);
    for (; i < args.size(); ++i) stmt2.bind(int(i + 1), args[i]);
    for (; i < 6; ++i) stmt2.bind(int(i + 1));

    /// Execute the statement.
    try {
        stmt2.exec();
    } catch (const std::exception& e) {
        fmt::print("Failed to add word '{}': {}\n", args[0], e.what());
        return;
    }
}

/// Add a definition to a word.
COMMAND (add_definition) {
    /// Must have two args.
    if (args.size() != 2) {
        fmt::print("Usage: d <word> <definition>\n");
        return;
    }

    /// Check if the word exists.
    SQLite::Statement stmt(*db, "SELECT 1 FROM words WHERE word = ?");
    stmt.bind(1, args[0]);
    if (not stmt.executeStep()) {
        fmt::print("Word '{}' does not exist.\n", args[0]);
        return;
    }

    /// Check if the definition already exists.
    SQLite::Statement stmt2(*db, "SELECT 1 FROM definitions WHERE word = ? AND definition = ?");
    stmt2.bind(1, args[0]);
    stmt2.bind(2, args[1]);
    if (stmt2.executeStep()) {
        fmt::print("Definition '{}' already exists for word '{}'.\n", args[1], args[0]);
        return;
    }

    /// Add the definition.
    SQLite::Statement stmt3(*db, "INSERT INTO definitions VALUES (?, ?)");
    stmt3.bind(1, args[0]);
    stmt3.bind(2, args[1]);

    /// Execute the statement.
    try {
        stmt3.exec();
    } catch (const std::exception& e) {
        fmt::print("Failed to add definition '{}': {}\n", args[1], e.what());
        return;
    }

}


/// List all words in the database.
COMMAND (list_words) {
    /// Select all words.
    SQLite::Statement stmt(*db, "SELECT * FROM words ORDER BY word");
    while (stmt.executeStep()) {
        fmt::print("\033[33m{}\033[32m", stmt.getColumn(0).getText());
        if (not stmt.isColumnNull(1)) fmt::print(" {}", stmt.getColumn(1).getText());
        if (not stmt.isColumnNull(2)) fmt::print(" {}", stmt.getColumn(2).getText());
        if (not stmt.isColumnNull(3)) fmt::print(" [{}]", stmt.getColumn(3).getText());
        if (not stmt.isColumnNull(4)) fmt::print(" F: {}", stmt.getColumn(4).getText());
        if (not stmt.isColumnNull(5)) fmt::print(" S: {}", stmt.getColumn(5).getText());
        fmt::print("\033[m\n");

        /// Select all definitions for the word.
        SQLite::Statement stmt2(*db, "SELECT definition FROM definitions WHERE word = ? ORDER BY definition");
        usz i = 1;
        stmt2.bind(1, stmt.getColumn(0).getText());
        while (stmt2.executeStep()) {
            fmt::print("    \033[34m{:<2}. {}\033[m\n", i++, stmt2.getColumn(0).getText());
        }
    }
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
                if (append_to->empty()) continue;
                append_to = &args.emplace_back();
            } break;

            default:
            default_:
                append_to->push_back(c);
                break;
        }
    }

    /// Remove empty arguments.
    std::erase_if(args, [](std::string_view arg) { return arg.empty(); });

    /// Handle the command.
    if (command == "a") add_word(std::move(args));
    else if (command == "d") add_definition(std::move(args));
    else if (command == "l") list_words(std::move(args));
    else if (command == "help") fmt::print("Commands: a, d, l, help, exit\n");
    else if (command == "exit") std::exit(0);
    else fmt::print("Unknown command: {}\n", command);
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
        dispatch_command(line);
    }
}
