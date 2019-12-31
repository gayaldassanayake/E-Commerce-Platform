module.exports = (errorCode) => {
    let errorMessages = {
        "00001" : "Invalid Username !",
        "00002" : "Invalid Password !"
    }
    return errorMessages[errorCode];
}