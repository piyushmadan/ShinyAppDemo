shinyServer(function(input, output) {
  
  #Data from DATA.CMS.GOV https://data.cms.gov/Medicare/Inpatient-Prospective-Payment-System-IPPS-Provider/97k6-zzx3
  data <- read.csv("Inpatient_Prospective_Payment_System__IPPS__Provider_Summary_for_the_Top_100_Diagnosis-Related_Groups__DRG__-_FY2011.csv")
  
  output$states = renderUI({
    # Reponse time for this is very low, hence pre-populated State is used in ui.R
    #selectInput('state','US State:',choice = as.character(unique(data$Provider.State)))  
  })

# Response time for procedure was very low, so prepopulated list of Procedures is used in ui.R
  output$procedure_name = renderUI({
    selectInput('procedure','Procedure name:', choice = as.character(unique(data$Provider.State))) 
  })
  
# renderDataTable gets list of procedure and price based on filters (State & procedure name)
output$procedure_detail <- renderDataTable(data[data$Provider.State==input$state & grepl(input$procedure,data$DRG.Definition),c(3:7,10,11)],                               
                              options = list(iDisplayLength = 10))  
})