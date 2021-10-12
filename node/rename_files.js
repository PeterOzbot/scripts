#!/usr/bin/env node

const dirPath = "/home/validus/Downloads/a-current/";
const removeText1 = "yt1s.com - ";
const removeText2 = "yt1s.com -";

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
    const newFilename = filename.replace(removeText1, "").replace(removeText2, "");

    FS.renameSync(filename, newFilename);
    console.log(`Renamed: ${newFilename}`);
});