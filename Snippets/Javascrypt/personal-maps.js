/**
 * Function that geo  code how about a place
 * @param {string} address
 * @return {Promise<object>}
 */
const geoCodeAddress = (address) =>
  new Promise((resolve, reject) => {
    const geocoder = new google.maps.Geocoder();
    geocoder.geocode({ address: address }, (results, status) => {
      if (status !== "OK") {
        reject({
          message: `Geocode was not successful for the following reason: ${status}`,
          results,
          status
        });

        return;
      }

      resolve(results);
    });
  });

const geoLocationAddress = async ({ address, country, state, city, map }) => {
  const text = [address, city, state, country]
    .filter((s) => s)
    .map((s) => s.trim())
    .join(", ");

  const response = await geoCodeAddress(text);

  if (response.length === 0) {
    return;
  }

  const [first] = response;
  map.setCenter(first.geometry.location);
  map.setZoom(18);

  const location = first.geometry.location;

  return { latitude: location.lat(), longitude: location.lng() };
};

const setLocationAddress = async (params) => {
  const inputLatitude = document.querySelector("input#latitude");
  const inputLongitude = document.querySelector("input#longitude");
  const checkCoords = document.querySelector(
    "input[type=checkbox]#latitude_longitude"
  );

  inputLatitude.value = "";
  inputLongitude.value = "";
  checkCoords.checked = false;
  window.address = false;

  await geoLocationAddress(params);

  if (markerRef) {
    markerRef.setMap(null);
  }
};

/**
 * Function that allow find a place with un write a address
 * @param {EventListener} event
 * @return {undefined}
 */
const findAddressGooglePersonal = async function (event) {

  console.log("debounced map, personal-maps...")

  const { target } = event;

  if (!target) {
    return;
  }

  const inputCity = document.querySelector("input[name=cityM]");
  const selectState = document.querySelector("select[name=stateM]");
  const selectCountry = document.querySelector("select[name=countryM]");

  if (!selectState || !selectCountry) {
    return;
  }

  const optionCountry =
    selectCountry.options[selectCountry.options.selectedIndex];
  const optionState = selectState.options[selectState.options.selectedIndex];

  const address = target.value;
  const city = inputCity.value;
  const country = (optionCountry && optionCountry.text) || "";
  const state = (optionState && optionState.text) || "";

  setLocationAddress({ address, country, state, city, map: mapRef });
};

const findAddressGooglePersonalDebounce = debounce(findAddressGooglePersonal, 1000);

const delayKeydownAddress = e => findAddressGooglePersonalDebounce(e);