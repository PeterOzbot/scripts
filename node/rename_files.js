#!/usr/bin/env node

const dirPath = "/home/validus/podcasts/";
const removeText1 = "yt1s.com - ";
const removeText2 = "yt1s.com -";
const removeText3 ="yt5s.com-";
const removeText4 ="yt5s.com-";

const Path = require("path");
const FS = require("fs");
let Files = [];

function ThroughDirectory(Directory) {
    FS.readdirSync(Directory).forEach(File => {
        const Absolute = Path.join(Directory, File);
        if (FS.statSync(Absolute).isDirectory()) return ThroughDirectory(Absolute);
        else return Files.push(Absolute);
    });
}

ThroughDirectory(dirPath);
Files.forEach(function (filename) {
    // remove prefix
    let newFilename = filename.replace(removeText1, "")
                              .replace(removeText2, "")
                              .replace(removeText3, "")
                              .replace(removeText4, "");

    // remove illegal characters
    newFilename = newFilename.replace(":", '').trim()
    newFilename = newFilename.replace("!", '').trim()

    // rename file
    FS.renameSync(filename, newFilename);
    console.log(`Renamed: ${newFilename}`);
});