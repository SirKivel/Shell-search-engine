

## File and process finder on Linux

For this test, a script in bash is needed to search for a specified process of a file or process within the system.

## Requirements

This script should prompt the user with the options of the search (process or file). Based on the selected search option, some other options must appear accordingly.

## File search

In case a file search is selected these are the expected options:
- Search by name
- Search by creation date
- Search by user
- Search by file extension
- Search by directory

By default, the search will look in all directories on /home unless it is specified by the Search by directory option. The expected output is the location of the file, size, name, permissions, user, and group.

After this a list of actions that can be performed:
- Move to the location
- Delete the file
- Copy to the current directory
- Show the content of the file
- Edit the file
- Exit

## Process search

In case process search is selected these are the expected options:
- Search by name
- Search by port
- Search by id

The expected outputs are name, user, PID, status.

After the search is performed a list of actions can be performed:
- Show more info (CPU and memory consumption, time and command)
- Stop the process
- Start the process
- Restart the process
- Exit

## Bonus

A progress bar of the search.
