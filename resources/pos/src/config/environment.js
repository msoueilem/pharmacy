// console.log('Debugin environment configuration loaded.');
// console.log("Current URL:", window.location.href);
// console.log("Protocol: " + window.location.protocol);
// console.log("Hostname: " + window.location.hostname);
// console.log("Port: " + window.location.port);
// console.log("Pathname: " + window.location.pathname);
// console.log("Search: " + window.location.search);
// console.log("Hash: " + window.location.hash);
export const environment = {
    URL: window.location.protocol + '//' + window.location.hostname + (window.location.port ? ':' + window.location.port : '') ,
};
