/* devicesignin.js — add a “Sign in to Azure” button in Voici */
define(["base/js/namespace", "base/js/events"], function (Jupyter, events) {
  function addAzureButton() {
    if (document.getElementById("azure-signin-btn")) return; // already added

    const btn = document.createElement("button");
    btn.id = "azure-signin-btn";
    btn.className = "btn btn-sm btn-primary";
    btn.innerText = "Sign in (Azure)";
    btn.title = "Acquire AAD token via device-code flow";

    btn.onclick = async () => {
      btn.disabled = true;
      btn.innerText = "Signing in …";

      const msal = await import(
        "https://cdn.jsdelivr.net/npm/@azure/msal-browser@3/+esm"
      );
      const app = new msal.PublicClientApplication({
        auth: {
          clientId: "YOUR_CLIENT_ID",
          authority: "https://login.microsoftonline.com/YOUR_TENANT",
        },
      });

      const res = await app.acquireTokenByDeviceCode({
        scopes: ["User.Read"],
        deviceCodeCallback: (msg) => alert(msg),
      });

      // push token into Python namespace
      Jupyter.notebook.kernel.execute(`AAD_TOKEN = "${res.accessToken}"`);
      btn.innerText = "Signed in ✓";
    };

    // insert right of the kernel name
    document.querySelector("#kernel_name").after(btn);
  }

  events.on("app_initialized.NotebookApp", addAzureButton);
});
