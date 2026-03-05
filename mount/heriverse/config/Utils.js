"use strict";
let Utils = {};
window.Utils = Utils;
Utils.baseName = "https://localhost/";

Utils.host = Utils.baseName + "server/heriverse/";
Utils.baseHost = Utils.baseName + "server/heriverse/";
Utils.baseUrl = Utils.baseName + "a/heriverse";
Utils.clientId = "heriverse";
Utils.loginUrl = Utils.baseName + "auth/realms/heriverse/protocol/openid-connect/auth";

export default Utils;