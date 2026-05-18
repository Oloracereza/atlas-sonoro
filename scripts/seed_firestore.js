const fs = require("fs");
const path = require("path");
const admin = require("firebase-admin");

const serviceAccountPath = process.env.GOOGLE_APPLICATION_CREDENTIALS;
const seedPath = path.join(__dirname, "..", "assets", "genres_seed.json");

if (!serviceAccountPath) {
  console.error("Falta GOOGLE_APPLICATION_CREDENTIALS.");
  console.error("Ejemplo:");
  console.error('  $env:GOOGLE_APPLICATION_CREDENTIALS="C:\\\\Users\\\\Lauro\\\\Downloads\\\\atlas-service-account.json"');
  process.exit(1);
}

if (!fs.existsSync(serviceAccountPath)) {
  console.error(`No existe la llave: ${serviceAccountPath}`);
  process.exit(1);
}

if (!fs.existsSync(seedPath)) {
  console.error(`No existe el archivo de datos: ${seedPath}`);
  process.exit(1);
}

admin.initializeApp({
  credential: admin.credential.cert(require(path.resolve(serviceAccountPath))),
});

const db = admin.firestore();

function buildSearchText(genre) {
  return [
    genre.name,
    genre.shortDescription,
    genre.scene,
    ...(genre.characteristics || []),
    ...(genre.keyArtists || []),
    ...(genre.keyRecords || []),
  ]
    .filter(Boolean)
    .join(" ")
    .toLowerCase();
}

async function main() {
  const genres = JSON.parse(fs.readFileSync(seedPath, "utf8"));
  const batch = db.batch();

  for (const genre of genres) {
    if (!genre.id) {
      throw new Error("Hay un genero sin id en genres_seed.json");
    }

    const { id, ...data } = genre;
    batch.set(db.collection("genres").doc(id), {
      ...data,
      searchText: buildSearchText(genre),
    });
  }

  await batch.commit();
  console.log(`Listo. Se subieron ${genres.length} generos a Firestore.`);
}

main().catch((error) => {
  console.error("No se pudo subir el seed a Firestore.");
  console.error(error);
  process.exit(1);
});
