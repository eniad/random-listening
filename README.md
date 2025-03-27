# Random Listening

This script returns a random album from one or more lists of albums for future listening.

## Script

The [random-listening.sh](./random-listening.sh) is a simple shell script. The script accepts positional arguments of directory and string to match. If no arguments are passed, it uses the current working directory, i.e. `.` and a default string of `\[ \]`. This default string is an unchecked item in markdown. More on markdown later.

The script uses the Linux command `grep` to return a list of match lines. Then it uses the Linux `rand` command to pick one of those lines at random.

## Markdown

Markdown is a popular text document format. It's human readable and many sites turn it into nice looking web pages. For example, GitHub uses markdown for [basic writing and formatting syntax](https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax).

## Lists

Lists can be kept for any logical category. Typical lists would be by artist or genre. Several example lists are included, [./artist/beatles](./artist/beatles) and [./genre/rock](./genre/rock)

## Examples

Any random album not yet listened to:

```bash
$ ./random-listening.sh
. ./artist/beatles.md:8:* [ ] The Beatles - Let it Be.
```

Note: The output could be cleaned up, but this meets the current need.

A random Beatles album (based on file path):

```bash
$ ./random-listening.sh beatles
artist/beatles.md 8:* [ ] The Beatles - Revolver.
```

A random rock album (based on file path):

```bash
$ ./random-listening.sh rock
genre/rock.md 7: [ ] The Rolling Stones - Sticky Fingers (1971).
```

A random album that matches "rolling" (based on file path and text):

```bash
$ ./random-listening.sh rock rolling
. ./genre/rock.md:5: [ ] The Rolling Stones - Beggar's Banquet (1968).
```

A random rock album that you have been listened (based on file path and text):

```bash
$ ./random-listening.sh rock "\[x\]"
. ./genre/rock.md:23 [x] Queen - Queen. There is a lot going on here; it constantly surprised me. Queen is a band of virtuosos. I hadn't heard this album. It's nice to visit a place that's familiar yet previously undiscovered
```

Note: Notes help remember the album listen.
