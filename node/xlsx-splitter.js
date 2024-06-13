console.clear();

const { readFileSync, mkdir, mkdirSync, existsSync } = require("fs");
const { join } = require("path");
const xlsx = require("xlsx");

const outDir = "generated/xlsx-splitter";
const storeToXlsx = (data, splitDir, fileName) => {
  try {
    // write in xlsx files
    fileName = `${fileName ?? Date.now()}` + ".xlsx";
    const dest = join(__dirname, splitDir, fileName);

    const book = xlsx.utils.book_new();
    const sheet = xlsx.utils.json_to_sheet(data);
    xlsx.utils.book_append_sheet(book, sheet);
    xlsx.writeFile(book, dest);

    console.log("Saved @", dest);
  } catch (error) {
    throw error;
  }
};

try {
  // TODO Number of records per sheet
  const perSheetLength = 100;

  // TODO enter the path of the file which need to be split
  const inputFile = join(__dirname, "inputs", "1718275932656.xlsx");

  const ipBook = xlsx.readFile(inputFile);
  const ipSheet = ipBook.Sheets["Sheet1"];

  const data = xlsx.utils.sheet_to_json(ipSheet);

  const iterations = Math.ceil(data.length / perSheetLength);
  const splitDir = join(outDir, `${Date.now()}`);
  mkdirSync(join(__dirname, splitDir));

  for (let i = 0; i < iterations; i++) {
    storeToXlsx(
      data.slice(i * perSheetLength, (i + 1) * perSheetLength),
      splitDir,
      i + 1
    );
  }
} catch (error) {
  console.log(error);
  console.error(error.message || error);
}
