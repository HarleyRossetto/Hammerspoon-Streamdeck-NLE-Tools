local logger = hs.logger.new("filesystem.lua", 4)

function openDirectory(directory)
    logger.df("Opening %s", directory)
    hs.execute(string.format("open \"%s\"", directory))
end