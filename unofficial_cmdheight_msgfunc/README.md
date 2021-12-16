# THIS IS FOR AN UNSUPPORTED AND UNOFFICIAL BUILD OF NEOVIM
## You WILL crash, alot, trying to get this stuff to work if you customize it even slightly.
## Hell, you might crash if you dont customize it at all.

### If you haven't been scared off yet, you are my kind of person. Read on
Ok so what ya gotta do is, clone the neovim fork from the dude who made this rfc
https://github.com/neovim/neovim/pull/16251

in case you mess up, checkout a new local branch. Call it msgfunc_cmdheight_merge or something equally ineloquent. while in that branch, run git merge on the cmdheight branch to get the changes from there. Then, merge the msgfunc branch in. It should merge both without problems. If you reaaaally live on the edge, pull updates from the official neovim master git before merging these in. 

The functionality is kinda cool, and it works stabily like 90% of the time. Usually when I run into an issue its some random edge case, or I pulled in updates first and some random bug shit happens that doesn't play nice. Enjoy.
