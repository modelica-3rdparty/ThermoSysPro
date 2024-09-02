within ThermoSysPro.Properties.ModelicaMedia.Media;
package CoolPropMedium "CoolProp medium, to be used as an example, to be duplicate in your study if needs to be changed"
  import ExternalMedia.Common.InputChoice;
  extends ExternalMedia.Media.CoolPropMedium(
    mediumName = "Water",
    substanceNames = {"Water"},
    inputChoice=InputChoice.ph);
end CoolPropMedium;
