import { Construct } from "constructs";
import { App, TerraformStack, TerraformOutput } from "cdktf";
import { AzurermProvider } from "@cdktf/provider-azurerm/lib/provider";
import { ResourceGroup } from "@cdktf/provider-azurerm/lib/resource-group";
import { ServicePlan } from "@cdktf/provider-azurerm/lib/service-plan";
import { LinuxWebApp } from "@cdktf/provider-azurerm/lib/linux-web-app";

class CDKTFDemo extends TerraformStack {
  constructor(scope: Construct, name: string) {
    super(scope, name);

    new AzurermProvider(this, "azureFeature", {
      features: {},
    });

    const rg = new ResourceGroup(this, "cdktf-rg", {
      name: "cdktf-demobook",
      location: "westeurope",
    });

    const asp = new ServicePlan(this, "cdktf-asp", {
      osType: "Linux",
      skuName: "S1",
      resourceGroupName: rg.name,
      location: rg.location,
      name: "cdktf-demobook"
    });

    const app = new LinuxWebApp(this, "cdktf-app", {
      name: "cdktf-demobook",
      location: rg.location,
      servicePlanId: asp.id,
      resourceGroupName: rg.name,
      clientAffinityEnabled: false,
      httpsOnly: true,
      siteConfig: {
      },
    });

    new TerraformOutput(this, "cdktf-app-url", {
      value: `https://${app.name}.azurewebsites.net/`,
    });
  }
}

const app = new App();
new CDKTFDemo(app, "azure-app-service");
app.synth();