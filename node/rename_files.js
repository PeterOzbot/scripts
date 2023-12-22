#!/usr/bin/env node

const dirPath = "/home/validus/podcasts/";
const removeText1 = "yt1s.com - ";
const removeText2 = "yt1s.com -";
const removeText3 = "yt5s.com-";
const removeText4 = "yt5s.com-";

const Path = require("path");
const FS = require("fs");
let Files = [];

function ThroughDirectory(Directory) {
    FS.readdirSync(Directory).forEach(File => {
        const Absolute = Path.join(Directory, File);
        if (FS.statSync(Absolute).isDirectory()) return ThroughDirectory(Absolute);
        else return Files.push({ existingAbsolutePath: Absolute, path: Directory, fileName: File });
    });
}

ThroughDirectory(dirPath);
Files.forEach(function (file) {
    // remove prefix
    let newFilename = file.fileName.replace(removeText1, "")
        .replace(removeText2, "")
        .replace(removeText3, "")
        .replace(removeText4, "");

    // remove illegal characters (all characters that do not match the set bellow = a-zA-Z and space and 0-9)
    newFilename = newFilename.replace(/[^a-zA-Z 0-9.]+/g, '').trim()

    // create new path
    const newAbsolutePath = Path.join(file.path, newFilename);

    // rename file
    FS.renameSync(file.existingAbsolutePath, newAbsolutePath);
    console.log(`Renamed: ${newAbsolutePath}`);
});