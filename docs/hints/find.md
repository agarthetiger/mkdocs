Use `locate` to find files by name. Use `sift` to search for text in files. Fallback to `find` only if locate doesn't work after updating the database index.

# find

* `find ~/ -iname '*.bak' -type f -maxdepth 1` Find all backup files (case-insensitive) in the specified folder only (no recursion)

# locate
The `updatedb` command for locate requires files to be readable by user nobody, group nobody or other in order to be indexed.

* `locate -i '*.bak'` - Use the locate database to find backup files (case-insensitive). Much faster than find but depends on files being indexed in the db.
* `sudo updatedb` Update the database used by locate.

# sift

* `sift "export BW_SESSION=" ~/.* 2>/dev/null` Search for the string "export BW_SECTION=" in any file in your home folder. Ignore stderr and only display matches.
