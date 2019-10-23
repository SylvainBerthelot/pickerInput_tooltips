library(shiny)
library(shinyjs)
library(shinyWidgets)

txt <- c("Explanation 1", "Explanation 2", "Explanation 3")
ui <- fluidPage(
  useShinyjs(),
  extendShinyjs(text = '
          shinyjs.pickerInput_tooltips = function(params){
          
          var defaultParams = {
            id : null,
            tooltips : null
          };
          params = shinyjs.getParams(params, defaultParams);
          
          var pickerInput = $("#"+params.id).closest("div").find(".dropdown-menu").get(1);
          var element_pickerInput = pickerInput.childNodes;
          
          if(element_pickerInput.length >0 && element_pickerInput[0].title == ""){ // to be trigger only once
            for(var i = 0; i< element_pickerInput.length; i++){
              element_pickerInput[i].title = params.tooltips[i];
            }
          }
          
        }; 
      '),
  pickerInput(inputId = "id", label = "Value :", choices = c("num1" = 1, "num2" = 2, "num3" = 3))
  
)
server <- function(input, output) {
  # throw your function when you click on pickerInput
  # Use this because if you don't click on it, the function couldn't work !
  # because choices of pickerInput doesn't exist yet
  onclick("id" ,js$pickerInput_tooltips("id",txt)) 
}
shinyApp(ui, server)
