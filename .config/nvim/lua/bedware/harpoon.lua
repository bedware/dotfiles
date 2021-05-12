require("harpoon").setup({
    projects = {
        ["/home/bedware/work/nrdp/backport-2"] = {
            term = {
                cmds = {
                    "ninja -C /home/bedware/work/nrdp/builds/backport-2 -j 25 && cp compile_commands.json /home/theprimeagen/work/nrdp/backport-2\n",
                }
            }
        }
    }
})

