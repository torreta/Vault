function validateForm() {

    console.log("validateForm del edit");

    var x;
    x = document.getElementById("name").value;
    if (x == "") {
        $('#myModal').modal('hide');
        alert("Faltan campos por favor rellenelos. (name edit) (3)");
        return false;
    };

    x = document.getElementById("email").value;
    if (x == "") {
        $('#myModal').modal('hide');
        alert("Faltan campos por favor rellenelos. (email edit) (3)");
        return false;
    };

    x = document.getElementById("birthdate").value;
    if (x == "") {
        $('#myModal').modal('hide');
        alert("Faltan campos por favor rellenelos. (birthdate edit) (3)");
        return false;
    };

    x = document.getElementById("phone").value;
    if (x == "" || x.length < 12) {
        $('#myModal').modal('hide');
        alert("Faltan campos por favor rellenelos. (telefono new) (3)");
        return false;
    };

    x = document.getElementById("sex").value;
    if (x == "") {
        $('#myModal').modal('hide');
        alert("Faltan campos por favor rellenelos. (sex edit) (3)");
        return false;
    };

    x = document.getElementById("country").value;
    if (x == "") {
        $('#myModal').modal('hide');
        alert("Faltan campos por favor rellenelos. (country edit) (3)");
        return false;
    };

    x = document.getElementById("state").value;
    if (x == "") {
        $('#myModal').modal('hide');
        alert("Faltan campos por favor rellenelos. (states edit) (3)");
        return false;
    };

    x = document.getElementById("address").value;
    if (x == "" || x.length < 20 ) {
        $('#myModal').modal('hide');
        alert("Faltan campos por favor rellenelos. (address edit) (3)");
        return false;
    };

    x = document.getElementById("reference").value;
    if (x == "" || x.length < 20 ) {
        $('#myModal').modal('hide');
        alert("Faltan campos por favor rellenelos. (reference edit) (3)");
        return false;
    };

    const container = document.getElementsByClassName('modal-content')[0];
    if(container.classList.contains('loader')) {
        container.classList.remove('loader');
    } else {
        container.classList.add('loader');
    }

    // if everything is correct.... 
    return true;
}


// Handle form submission.
var form = document.getElementById('form_id');

    form.addEventListener('submit', function(event) {
    event.preventDefault();

    // si la validacion hace su trabajo... no hace submit 
    if (validateForm()){
        form.submit();
    }

});