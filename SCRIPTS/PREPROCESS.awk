# Reference lines are single fields that contain a '>'
NF < 2 && $1 ~ ">" {
    # Collapse whitespace.
    gsub(/  +/, " ", $1)

    # Split by the '>' character and trim rhs.
    split($1, line, ">")
    gsub(/^ +/, "", line[2])

    # Split lhs by commas.
    split(line[1], refs, ",")

    # For each ref, trim it and print a line with the ref and the rhs.
    for (i in refs) {
        gsub(/^ +/, "", refs[i])
        print refs[i] ">" line[2]
    }
    next
}

# Collapse whitespace and print.
{
    # Collapse whitespace.
    gsub(/  +/, " ", $0)
    print
}