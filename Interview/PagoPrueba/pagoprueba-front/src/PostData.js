export default function PostData(type, userData) {
    
    let baseUrl = 'http://localhost:3001/api';

    console.log(JSON.stringify(userData));

    return new Promise((resolve, reject) => {
        fetch(baseUrl+type,{
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
            body: JSON.stringify(userData)
        })
        .then((response) => response.json())
        .then((responseJson) => {
            resolve(responseJson);
        })
        .catch((error) => {
            reject(error);
        })
    });
}

