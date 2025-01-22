
  getCoordinatesFromAddress: async function (full_address_description) {
    const API_KEY = "API_KEY HERE";
    const ADDRESS = full_address_description;
    console.log(`https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(ADDRESS)}&key=${API_KEY}`);
    try {
        const response = await Axios({
            url: `https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(ADDRESS)}&key=${API_KEY}`,
            method: 'GET',
            timeout: 50000,
        });

        console.log("================ RESPUESTA MAPA ===================");
        console.log(response);
        console.log("================ RESPUESTA MAPA =================== END");
        if (response.data.status === "OK") {
            const location = response.data.results[0].geometry.location;
            console.log(`Latitude: ${location.lat}, Longitude: ${location.lng}`);
            return location; // Return the coordinates
        } else {
            console.log("Error:", response.data.status);
            throw new Error(response.data.status); // Throw an error for non-OK status
        }
    } catch (error) {
        console.error("Error:", error);
        throw error; // Re-throw the error for further handling
    }
}
