
var validatelang = {
    Currency: {
        MustNumber: " must be a number and cannot be empty\n",
        NoSymbol: " amount you entered must be a number without currency symbol\n"
        },
    Number: {
        MustNumber: " must be a number and cannot be empty\n",
        NoDecimal: " must be a number (no decimal points) and cannot be empty\n" 
        },
    Float: {
        MustNumber: " must be a number and may contain a decimal point.\n" 
        },
    Enter: {
        PleaseEnter: "- Please enter "
    },			        
    Select: {
        PleaseSelect: "- Please select ",
        MustSelect: " must be selected\n"
    },
    Email: {
        ValidEmail: "- Please enter a valid email address\n",
        Illegal: "- The email address contains illegal characters\n"
    },
    CheckDate: {
        ValidDate: " as a valid date.\n"
    },
    Others:{
        CannotContain: " cannot contain ",
        WhiteSpace: "white spaces\n",
        Character: "character.\n"
    },
    IP:{
	    Illegal: "- Please enter a valid IP Address"
    }
};