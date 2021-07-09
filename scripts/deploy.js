async function main() {
    const SatellitesSoundsBeyondSightTiangong1 = await ethers.getContractFactory("SatellitesSoundsBeyondSightTiangong1");
    
    // Start deployment, returning a promise that resolves to a contract object
    const satellitesSoundsBeyondSightTiangong1 = await SatellitesSoundsBeyondSightTiangong1.deploy();
    console.log("Contract deployed to address:", satellitesSoundsBeyondSightTiangong1.address);
 }
 
 main()
   .then(() => process.exit(0))
   .catch(error => {
     console.error(error);
     process.exit(1);
   });