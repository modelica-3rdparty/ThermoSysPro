within ThermoSysPro.Properties;
package CoolPropMedium "CoolPropMedium to be used as an example, to be duplicate in your study if needs to be changed"
  import ExternalMedia.Common.InputChoice;
  extends ExternalMedia.Media.CoolPropMedium(
    mediumName = "Water",
    substanceNames = {"Water"},
    inputChoice=InputChoice.ph);
end CoolPropMedium;
