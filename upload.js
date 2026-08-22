const { initializeApp, cert } = require('firebase-admin/app');
const { getFirestore } = require('firebase-admin/firestore');
const fs = require('fs');
const path = require('path');

// 1. Load your Firebase Service Account key
const serviceAccount = require('./snapcart-mobile-app-2026-425ea-firebase-adminsdk-fbsvc-96fcebc1e0.json');

// 2. Initialize Firebase Admin SDK
initializeApp({
  credential: cert(serviceAccount)
});

const db = getFirestore();

// 3. Load the products JSON file
const productsPath = path.join(__dirname, 'dummy_products.json');
const productsData = JSON.parse(fs.readFileSync(productsPath, 'utf8'));

async function importProducts() {
  console.log('🚀 Starting products import to Firestore...');
  
  const collectionRef = db.collection('products');
  let successCount = 0;

  for (const item of productsData) {
    try {
      // Use the custom 'id' field (prod_001) as the Firestore Document ID
      const docRef = collectionRef.doc(item.id);
      
      // Upload product object
      await docRef.set(item);
      
      console.log(`✅ Uploaded: ${item.id} - ${item.title}`);
      successCount++;
    } catch (error) {
      console.error(`❌ Failed to upload ${item.id}:`, error.message);
    }
  }

  console.log(`\n🎉 Import complete! Successfully added ${successCount}/${productsData.length} products.`);
  process.exit(0);
}

// Execute upload
importProducts().catch((error) => {
  console.error('Fatal execution error:', error);
  process.exit(1);
});