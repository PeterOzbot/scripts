const dirPath = "/home/validus/Downloads/a-current/scott";
const removeText = "yt1s.com - ";

const fs = require('fs');

const files = fs.readdirSync(dirPath);
files.forEach(function(filename) {
   const newFilename = filename.replace(removeText,"");

    fs.renameSync(`${dirPath}/${filename}`, `${dirPath}/${newFilename}`);
});