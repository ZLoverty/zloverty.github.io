### Server plans

I plan to make my PMMH computer a better server. Here is a to-do list. As things are being implemented, I will keep records of how they are done here for future reference.

- Instead of typing in raw IP address, make an alias for the server, such as @pmmh, @pmmh1
- ~~Mount external drives to the same folder, so it's easier to retrieve data and no need to remember where data are physically located. [mergerfs](https://github.com/trapexit/mergerfs)~~ This is done by creating shortcuts in the home directory. For example, `~/drives` links to `/media/zhengyang/`, so I can use `~/drives/[drive name]` to direct to the external drive folders.
- Implement RAID redundancy to keep data secure.
