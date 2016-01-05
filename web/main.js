function callNativeApp () {
    try {
        webkit.messageHandlers.indexCallback.postMessage(["Eggs", "Milk"]);
    } catch(err) {
        console.log('The native context does not exist yet');
    }
}

setTimeout(function () {
           callNativeApp();
           }, 5000);

function redHeader() {
    document.querySelector('h1').style.color = "red";
}