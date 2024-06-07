console.clear();

const { readFileSync } = require("fs");
const { join } = require("path");
const xlsx = require("xlsx");

try {
  // TODO Enter the number of records to generate
  const records = 1000;

  // TODO add the files to read json from
  const inputDir = "inputs";
  const inputJSONs = [join(__dirname, inputDir, "sample.json")];

  // reading all the json
  const jsons = inputJSONs.map((url) => {
    const data = readFileSync(url);
    return JSON.parse(data);
  });

  console.info("data loaded");

  // get random value from array
  const getRandom = (arr) => {
    const randomIndex = Math.ceil(arr?.length * Math.random()) - 1;
    if (randomIndex === -1) return "";
    return arr[randomIndex];
  };

  // generate random data
  const data = [];
  let i = 0;
  while (i < records) {
    const row = {};
    jsons.forEach((d, i) => {
      row[i] = getRandom(d);
    });
    data.push(row);
    i++;
  }

  console.info("data generated");
  console.log(data);

  // write in xlsx files
  const outDir = "generated";
  const filesName = Date.now() + ".xlsx";
  const dest = join(__dirname, outDir, filesName);

  console.log(dest);
  const book = xlsx.utils.book_new();
  const sheet = xlsx.utils.json_to_sheet(data);
  xlsx.utils.book_append_sheet(book, sheet);
  xlsx.writeFile(book, dest);

  console.log("Saved @", dest);
} catch (error) {
  console.log(error);
  console.error(error.message || error);
}
