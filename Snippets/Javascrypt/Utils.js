var URL_MODULE = (function () {

    var BASE_URL = window.location.origin + getPath();
    var CTRL_URL = BASE_URL + "/controllers/";

    return {
        BASE_URL: BASE_URL,
        CTRL_URL: CTRL_URL
    };

})();


function Limit_Percentage(data){
    return (parseFloat(data)<=100 && parseFloat(data)>=0);
}


function Code_Client(data){
    console.log(data);
    var expreg = new RegExp("^CL\\d{1,6}$");
    console.log(expreg.test(data));
    return expreg.test(data);
}

function IsPositive(data){
    console.log(data>=0);
    return (data>=0);
}

function Telefhone(data){
    var exp = /\(?([0-9]{4})\)?([ .-]?)([0-9]{3})([ .-]?)([0-9]{2})([ .-]?)([0-9]{2})/;
    return (exp.test(data));
}

function Discount_Percentage(data){
    console.log('DESCUENTO  '+data);
    return (data>=0 && data<=10);
}

function Valid_limit(data){
    console.log(data>=1);
    return (data>=1);
}

function convertTimestamp(timestamp) {
    var d = new Date(timestamp * 1000),	// Convert the passed timestamp to milliseconds
        yyyy = d.getFullYear(),
        mm = ('0' + (d.getMonth() + 1)).slice(-2),	// Months are zero based. Add leading 0.
        dd = ('0' + d.getDate()).slice(-2),			// Add leading 0.
        hh = d.getHours(),
        h = hh,
        min = ('0' + d.getMinutes()).slice(-2),		// Add leading 0.
        ampm = 'AM',
        time;

    if (hh > 12) {
        h = hh - 12;
        ampm = 'PM';
    } else if (hh === 12) {
        h = 12;
        ampm = 'PM';
    } else if (hh == 0) {
        h = 12;
    }

    time = dd + '-' + mm + '-' + yyyy + ', ' + h + ':' + min + ' ' + ampm;

    return time;
}

function convertTimestamp2(timestamp) {
    var d = new Date(timestamp),	// Convert the passed timestamp to milliseconds
        yyyy = d.getFullYear(),
        mm = ('0' + (d.getMonth() + 1)).slice(-2),	// Months are zero based. Add leading 0.
        dd = ('0' + d.getDate()).slice(-2),			// Add leading 0.
        hh = d.getHours(),
        h = hh,
        min = ('0' + d.getMinutes()).slice(-2),		// Add leading 0.
        ampm = 'AM',
        time;

    if (hh > 12) {
        h = hh - 12;
        ampm = 'PM';
    } else if (hh === 12) {
        h = 12;
        ampm = 'PM';
    } else if (hh == 0) {
        h = 12;
    }

    time = dd + '-' + mm + '-' + yyyy + ', ' + h + ':' + min + ' ' + ampm;

    return time;
}

function setRemainingTime(seconds) {
    var date = new Date();
    date.setSeconds(date.getSeconds()+seconds);
    localStorage.setItem("remaining_time", date.getTime());
}

function setTimeoutTime(seconds) {
    // System timeout time less 5 minutes
    localStorage.setItem("timeout", seconds*1000);
}


Array.prototype.move = function (from, to) {
    this.splice(to, 0, this.splice(from, 1)[0]);
    return this;
};

Array.prototype.unique = function(){
    var u = {}, a = [];
    for(var i = 0, l = this.length; i < l; ++i){
        if(u.hasOwnProperty(this[i])) {
            continue;
        }
        a.push(this[i]);
        u[this[i]] = 1;
    }
    return a;
}

Array.prototype.indexOfStr = function (str) {
    for (var j=0; j<this.length; j++) {
        if (this[j].match(str)) return j;
    }
    return -1;
}

Array.prototype.allIndexOfStr = function (str) {
    var pos = [];
    for (var j=0; j<this.length; j++) {
        if (this[j].match(str))
            pos.push(j);
    }
    return pos.length > 0 ? pos : -1;
}

Array.prototype.remove = function(ind){
    if(ind.constructor === Array){
        var n = ind.length;
        for(var i = 0; i < n ; i++){
            this.splice(ind[i]-i,1);
        }
    }else{
        this.splice(ind,1);
    }
    return this;
};

function getPath() {
    var url = window.location.pathname;
    var murl = url.split("/");
    if(murl[1] !== "" && murl[1] !== "apps"){
        return "/" + murl[1] + "/" + murl[2];
    }else{
        return "";
    }
}

function ValidPercentage(data) {
    return (data <= 100 && data >= 0);
}

function ValidPercentageNoLimit(data) {
    return (data >= 0);
}


function ValidDatePayment(data) {
    return (data <= new Date());
}

function ValidPositiveNumber(data) {
    return (data >= 0);
}

dhtmlXTabBar.prototype.addTabRole = function (needles, id, text, width, position, active, close) {
    var haystack = RoleCheck.list();
    var that = this;
    for (var i = 0, len = needles.length; i < len; i++) {
        if ($.inArray(needles[i], haystack) == -1) {
        } else {
            that.addTab(id, text, width, position, active, close);
            return;
        }
    }
}

dhtmlXForm.prototype.loadProgress = function(data,container){
    container.progressOn();
    this.load(data,function(){
        container.progressOff();
    });
}

dhtmlXGridObject.prototype._in_header_stat_balance = function (tag, index, data) {
    var mgrid = this;
    var calck = function () {
        var sum = 0;
        for (var i = 0; i < mgrid.getRowsNum(); i++) {
            sum += mgrid.cells2(i, 5).getValue() - mgrid.cells2(i, 3).getValue();
        }
        ;
        return this._aplNF(sum, 0);
    }
    this._stat_in_header(tag, calck, index, data); // default statistics handler processor
}

dhtmlXGridObject.prototype._in_header_stat_balance_debt = function (tag, index, data) {
    var calck = function () {
        var previous_client = 0;
        var sum_invoice = 0;
        var sum_payment = 0;
        var sum = 0;
        var ids = this.getAllRowIds();
        ids = ids.split(",");
        var grid = this;

        // Primer cliente
        if (ids.length > 0) {
            previous_client = grid.cellById(ids[0], 0).getValue();
        }

        for (var i = 0; i < grid.getRowsNum(); i++) {
            if (grid.cells2(i, 0).getValue() !== previous_client) {
                if (sum_invoice > sum_payment) {
                    sum += sum_invoice - sum_payment;
                }
            }
            sum_invoice = grid.cells2(i, 6).getValue();
            sum_payment = grid.cells2(i, 7).getValue();
            previous_client = grid.cells2(i, 0).getValue();
        }
        if (parseFloat(sum_invoice) > parseFloat(sum_payment)) {
            sum += sum_invoice - sum_payment;
        }

        if (sum < 0) {
            sum = 0;
        }

        return this._aplNF(sum, 0);
    }
    this._stat_in_header(tag, calck, index, data); // default statistics handler processor
}

// Utils Definition
function Utils() {

}

// Functions definitions

// Hello World Test
Utils.prototype.hello = function () {
    console.log("Hello World!. It works!");
}


Utils.prototype.gridToParam = function (name, grid) {
    return "&" + name + "=" + grid.getAllRowIds();
}

Utils.prototype.observation = function (mCallback) {
    var structure = [
        {type: "settings", position: "label-left", labelWidth: 100, inputWidth: 150},
        {
            type: "block", inputWidth: "auto", offsetTop: 12, list: [
            , {"type": "input", "name": "obs", "label": "Observación", "required": true, "validate": "NotEmpty"}
            , {"type": "button", "name": "save", "1": "Guardar"}
        ]
        },
    ];

    var dhxWins = new dhtmlXWindows();
    var mWindow = dhxWins.createWindow("mWindow", 10, 10, 310, 150);
    mWindow.denyResize();
    mWindow.setText("Observación");
    mWindow.center();

    var mForm = mWindow.attachForm(structure, true);
    mForm = mForm.getForm();
    mForm.enableLiveValidation(true);

    mForm.attachEvent("onButtonClick", function (id) {
        if (!mForm.validate()) return;
        mCallback(mForm.getItemValue("obs"), mWindow);
        mWindow.close();
    });

}

Utils.prototype.inventoryObservation = function (mCallback) {
    var structure = [
        {type: "settings", position: "label-left", labelWidth: 100, inputWidth: 150},
        {
            type: "block", inputWidth: "auto", offsetTop: 12, list: [
            , {"type": "input", "name": "obs", "label": "Observación", "required": true, "validate": "NotEmpty"}
            , {
                "type": "select",
                "name": "type_id",
                "label": "Tipo",
                "required": true,
                "validate": "NotEmpty",
                connector: URL_MODULE.CTRL_URL + "Lots.php?call=inventoryLogTypes"
            }
            , {
                "type": "combo",
                "name": "responsible",
                "label": "Responsable",
                "required": true,
                "validate": "NotEmpty",
                connector: URL_MODULE.CTRL_URL + "Inventory.php?call=combo_seeker_packer"
            }
            , {'type': "checkbox", 'name':'me', 'label': "Operador", 'checked': false},
            , {"type": "button", "name": "save", "value": "Guardar"}
        ]
        },
    ];

    var dhxWins = new dhtmlXWindows();
    var mWindow = dhxWins.createWindow("mWindow", 10, 10, 310, 230);
    mWindow.denyResize();
    mWindow.setText("Observación");
    mWindow.center();

    var mForm = mWindow.attachForm(structure, true);
    mForm = mForm.getForm();
    mForm.enableLiveValidation(true);
    // mForm.getCombo('responsible').enableFilteringMode('between', URL_MODULE.CTRL_URL + "Inventory.php?call=combo_seeker_packer", null, true);
    mForm.attachEvent("onChange", function (name, value, is_checked) {

            if (name == 'me') {
                if (is_checked == true) {
                    /* Si se selecciono el checkbox de "YO" entonces se deshabilita el combo del responsable, se limpia el texto que habia
                       y se coloca que ya el campo no es requerido */
                    // mForm.getCombo('responsible').clearAll();
                    mForm.getCombo('responsible').setComboText("");
                    mForm.getCombo('responsible').enable(false);
                    mForm.setRequired('responsible',false);
                } else {
                    /*Se coloca el combo como requerido y se habilita*/
                    mForm.getCombo('responsible').enable(true);
                    mForm.setRequired('responsible',true);
                }
            }

    });

    mForm.attachEvent("onButtonClick", function (id) {
        if (!mForm.validate()) return;

        var responsible;
        if (mForm.getItemValue("responsible") === "")
            responsible = 'yo';
        else
            responsible = mForm.getItemValue("responsible");

        mCallback(mForm.getItemValue("obs"), mForm.getItemValue("type_id"), responsible);
        mWindow.close();
    });

}

Utils.prototype.inventoryResponsibleObservation = function (mCallback) {
    var structure = [
        {type: "settings", position: "label-left", labelWidth: 100, inputWidth: 150},
        {
            type: "block", inputWidth: "auto", offsetTop: 12, list: [
            , {"type": "input", "name": "obs", "label": "Observación(*)", "required": true, "validate": "NotEmpty"}
            , {
                "type": "select",
                "name": "type_id",
                "label": "Tipo",
                "required": true,
                "validate": "NotEmpty",
                connector: URL_MODULE.CTRL_URL + "Lots.php?call=inventoryLogTypes"
            }
            , {
                "type": "combo",
                "name": "responsible_type",
                "label": "Responsable",
                "required": true,
                "validate": "NotEmpty",
                connector: URL_MODULE.CTRL_URL + "Responsible.php?call=combo_responsible_type"
            },
            {
                type: "combo",
                name: "responsible_id",
                label: "Encargado",
                required: true,
            },
            , {"type": "button", "name": "save", "value": "Guardar"}
        ]
        },
    ];

    var dhxWins = new dhtmlXWindows();
    var mWindow = dhxWins.createWindow("mWindow", 10, 10, 310, 230);
    mWindow.denyResize();
    mWindow.setText("Observación");
    mWindow.center();

    var mForm = mWindow.attachForm(structure, true);
    mForm = mForm.getForm();
    mForm.enableLiveValidation(true);
    
    // mForm.getCombo('responsible').enableFilteringMode('between', URL_MODULE.CTRL_URL + "Inventory.php?call=combo_seeker_packer", null, true);
    mForm.attachEvent("onChange", function (name, value) {
        if(name === "responsible_type") comboResponsible(value, mForm);
    });

    mForm.attachEvent("onButtonClick", function (id) {
        
        // si falla la validacion, no continuar
        if (!mForm.validate()) return;
        
        var responsible_type = mForm.getItemValue('responsible_type')
        var responsible = mForm.getItemValue('responsible_id')
        // valores sacados del callback
        mCallback(mForm.getItemValue("obs"), mForm.getItemValue("type_id"),responsible_type, responsible);
        
        // close windows passed down
        mWindow.close();
    });

    // Fill responsible
    function comboResponsible(type_id, mForm) {
        
        // cleaning responsible input
        mForm.getCombo('responsible_id').hide(false);
        mForm.getCombo('responsible_id').enable(true);
        mForm.setRequired('responsible_id',true);    
        mForm.getCombo("responsible_id").clearAll();
        mForm.getCombo("responsible_id").setComboText("");        
        
        //loading new info on responsible id combo
        var responsible = mForm.getCombo("responsible_id");
        responsible.load(URL_MODULE.CTRL_URL + "Responsible.php?call=combo_responsible&type_id="+type_id);
        responsible.enableFilteringMode('between', null, null, true);

        //not necesary if current user
        if(type_id == 1){
            mForm.getCombo('responsible_id').hide(true);
            mForm.getCombo('responsible_id').enable(false);
            mForm.getCombo('responsible_id').disable(true);
            mForm.setRequired('responsible_id',false);    
            mForm.getCombo("responsible_id").setComboText("Usuario Actual");        
        }
    };

}

// Highlight grid row on right click
Utils.prototype.selectRowOnRightClick = function (grid) {

    grid.attachEvent("onBeforeContextMenu", function (rowId, celInd) {
        grid.selectRowById(rowId);
        return true;
    });
}

Utils.prototype.deleteRowFromGrid = function (table, id, grid) {
    dhtmlx.confirm({
        type: "confirm",
        text: "Se <b>borrará</b> el registro. ¿Desea continuar?",
        callback: function (result) {
            if (!result)    return;

            var url = "../../services/delete.php?table=" + table + "&columns=id&values=" + id;
            var r = window.dhx4.ajax.postSync(url);

            if (r.xmlDoc.status !== 200) {
                dhtmlx.message({
                    title: "Error",
                    type: "alert-error",
                    text: r.xmlDoc.responseText,
                    callback: function () {
                        return true;
                    }
                });
            } else {
                dhtmlx.message({
                    title: "Éxito",
                    type: "alert",
                    text: "El registro ha sido eliminado.",
                    callback: function () {
                        return true;
                    }
                });
                grid.reload();
            }

        }//end callback
    });//end confirm
}

Utils.prototype.deleteGridByUrl = function (url, grid) {
    dhtmlx.confirm({
        type: "confirm",
        text: "Se <b>borrará</b> el registro. ¿Desea continuar?",
        callback: function (result) {
            if (!result)    return;

            var r = window.dhx4.ajax.postSync(url);

            if (r.xmlDoc.status !== 200) {
                dhtmlx.message({
                    title: "Error",
                    type: "alert-error",
                    text: r.xmlDoc.responseText,
                    callback: function () {
                        return true;
                    }
                });
            } else {
                dhtmlx.message({
                    title: "Éxito",
                    type: "alert",
                    text: "El registro ha sido eliminado.",
                    callback: function () {
                        return true;
                    }
                });
                grid.reload();
            }

        }//end callback
    });//end confirm
}


/*
 * @success: Boolean. Determina si el proceso realizado antes de este mensaje
 *                    fue ejecutado con exito o no.
 * @text: String. Mensaje personalizado para el mensaje. User null si se desea
 *                usar el mensaje predeterminado
 *
 * Ejm: (new Utils).confirmWindow(true,"Esto es un mensaje")
 * Ejm: (new Utils).confirmWindow(false,null)
 */
Utils.prototype.confirmWindow = function (success, text) {
    var msg = text;
    var w_title = "Error";
    var w_type = "alert-error";

    if (text === null) {
        if (success) {
            msg = "La operación fue realizada con éxito.";
        } else {
            msg = "La operación no pudo ser procesada.";
        }
    }

    if (success) {
        w_title = "Confirmar";
        w_type = "alert";
    }

    dhtmlx.message({
        title: w_title,
        type: w_type,
        text: msg,
        callback: function () {
            return true;
        }
    });

};

/*
 * @tree: dhtmlxTreeObject. Objeto Arbol dhtmlx
 * @level: Integer. Nivel del arbol a refrescar.
 Si se indica null, se refresca todo el arbol
 *
 * Ejm: (new Utils).refreshTree(tree,0);
 * Ejm: (new Utils).refreshTree(tree,null);
 * Ejm: (new Utils).refreshTree(tree,2);
 */
Utils.prototype.refreshTree = function (tree, level) {

    var lvl = level;
    if (level === null)  lvl = 0;

    if (!tree)  return;

    if (isNaN(lvl))  return;

    tree.deleteChildItems(lvl);
    tree.load(tree.XMLsource);
}

/*
 * Generar N opciones para un dhtmlxComboObject
 *
 * @n: Integer. Cantidad de opciones a crear
 *
 * Ejm: (new Utils).generateSequenceOptions(10);
 */
Utils.prototype.generateSequenceOptions = function (n) {
    var options = "";
    n = n + 1;
    for (var i = 1; i < n; i++) {
        options += '{value: "' + i + '", text: "' + i + '"},';
    }
    return '{options:[' + options + ']}';
}

/*
 * Generar N opciones para un dhtmlxComboObject
 *
 * @n: Integer. Cantidad de opciones a crear
 *
 * Ejm: (new Utils).generateOptions({1,2,3,4,5});
 */
Utils.prototype.generateOptions = function (list) {
    var options = "";
    n = list.length;
    for (var i = 0; i < n; i++) {
        options += '{value: "' + list[i] + '", text: "' + list[i] + '"},';
    }
    return '{options:[' + options + ']}';
}

/*
 * Generar Parametros para URL desde un JSON
 *
 * @json: Json Object. JSON con la estructura de los parametros
 *
 * Ejm: (new Utils).jsonToParams(var json = {clave: valor, clave: valor});
 */
Utils.prototype.jsonToParams = function (json) {
    var params = Object.keys(json).map(function (key) {
        return encodeURIComponent(key) + '=' + encodeURIComponent(json[key]);
    }).join('&');
    return params;
}

/*
 * Generar Parametros para URL desde un JSON. No cuenta los vacios
 *
 * @json: Json Object. JSON con la estructura de los parametros
 *
 * Ejm: (new Utils).jsonToParams2(var json = {clave: valor, clave: valor});
 */

Utils.prototype.jsonToParams2 = function (json) {
    var params = [];
    Object.keys(json).map(function (key) {
        if (encodeURIComponent(json[key]) !== "") {
            params.push(encodeURIComponent(key) + '=' + encodeURIComponent(json[key]));
        }
    });
    return params.join('&');
}

Utils.prototype.JSONBIGPARSER = function (string) {
    var rq = ""; //request http
    var buffer = "";
    var largo = 0;
    var items = {};
    var items2 = {};
    var estados = "";

    /*
     Cambia a donde va el request para que te de los datos que quieres
     */

    buffer = string;

    buffer = buffer.substring(1);

    buffer = buffer.trim();

    largo = buffer.length;

    buffer = buffer.substring(0, largo - 1);


    /*
     El proximo split lo hago para separar los elementos del buffer de JSONS
     */

    items = buffer.split("},{");

    //console.log(items);

    //para normalizar los elementos, despues de separarlos y quitarle esos caracteres
    if (items.length > 1) {
        for (var i = 0; i < items.length; i++) {

            if (i == 0) { //primero
                items[i] = items[i] + "}";
            }
            if ((i > 0) && (i < items.length - 1)) {//intermedio
                items[i] = "{" + items[i] + "}";
            }
            if (i == items.length - 1) {//ultimo
                items[i] = "{" + items[i];
            }
            ////console.log(items[i]);
            items2[i] = JSON.parse(items[i]);
        }

        largo = items.length;

    } else {
        //console.log(buffer);
        items2[0] = JSON.parse(buffer);
        largo = 1;
    }

    items2.length = largo; //al parecer el objeto necesita que le de el valor de este atributo

    return (items2);

}//Big Parser

// Pase XML to JSON format
Utils.prototype.xmlTojson = function xml2json(xmlDoc) {
    xmlDoc = jQuery.parseXML(xmlDoc);
    // xml = $.parseXML(xml);
    // console.log(xmlDoc);

    xmlToJson = function (xml) {
        var obj = {};
        if (xml.nodeType == 1) {
            if (xml.attributes.length > 0) {
                obj["@attributes"] = {};
                for (var j = 0; j < xml.attributes.length; j++) {
                    var attribute = xml.attributes.item(j);
                    obj["@attributes"][attribute.nodeName] = attribute.nodeValue;
                }
            }
        } else if (xml.nodeType == 3) {
            obj = xml.nodeValue;
        }
        if (xml.hasChildNodes()) {
            for (var i = 0; i < xml.childNodes.length; i++) {
                var item = xml.childNodes.item(i);
                var nodeName = item.nodeName;
                if (typeof (obj[nodeName]) == "undefined") {
                    obj[nodeName] = xmlToJson(item);
                } else {
                    if (typeof (obj[nodeName].push) == "undefined") {
                        var old = obj[nodeName];
                        obj[nodeName] = [];
                        obj[nodeName].push(old);
                    }
                    obj[nodeName].push(xmlToJson(item));
                }
            }
        }
        return obj;
    }

    return xmlToJson(xmlDoc);

}

// filterCalendar is a function that generates a modal that allows the user filter
// by a date range.
// IF YOU DON'T KNOW HOW TO USE IT.. visit: drotaca/app/js/readmeFilterCalendar.txt 
Utils.prototype.filterCalendar = function (grid,url) {

    // 1-- create a window
    var dhxWins = new dhtmlXWindows();
    var mWindow = dhxWins.createWindow("mWindow", 100, 100, 270, 210);
    mWindow.denyResize();
    mWindow.setText("Filtrar por fecha");
    mWindow.center();
    // 2-- create a form
    var structure = [
        {type: "settings", position: "label-left", labelWidth: 100, inputWidth: 200},
        {
            type: "block", inputWidth: "auto", offsetTop: 15, list: [
                {
                    type: "calendar",
                    name: "begin_date",
                    label: "Fecha de inicio",
                    dateFormat: "%d-%m-%Y",
                    serverDateFormat: "%Y-%m-%d",
                    calendarPosition: "right",
                    required: true,
                },
                {
                    type: "calendar",
                    name: "end_date",
                    label: "Fecha final",
                    dateFormat: "%d-%m-%Y",
                    serverDateFormat: "%Y-%m-%d",
                    calendarPosition: "right",
                    required: true,
                },
                {type: "button", name: "filter_calendar", value: 'Filtrar'}
            ]
        },
    ];

    var mForm = mWindow.attachForm(structure,true);
    mForm = mForm.getForm();
    mForm.enableLiveValidation(true);

    //3-- We change the USA-dateformat to spanish-dateformat
    mForm.getCalendar("begin_date").loadUserLanguage("es");
    mForm.getCalendar("end_date").loadUserLanguage("es");


    mForm.attachEvent("onButtonClick", function (id) {
        grid.grid.first();       

        // catch both dates 
        var begin_date = (new Date(mForm.getItemValue("begin_date")).toJSON().slice(0, 10));
        var end_date = (new Date(mForm.getItemValue("end_date")).toJSON().slice(0, 10));
        // compare both dates
        if (begin_date <= end_date) {
            grid.load(url+"&begin_date=" + begin_date + "&end_date=" + end_date);
            mWindow.close();  
        }else{
            (new Utils).confirmWindow(false, "Coloque mejor las fechas");
        }

    });
}