({
 onLoad: function(component, event) {
  console.log('onLoad call');
  
  //call apex class method
  var loadHeader = component.get('c.loadCSV');
  loadHeader.setCallback(this, function(response) {
   //store state of response
   var state = response.getState();
   if (state === "SUCCESS") {
       
    component.set('v.ListOfHeader', response.getReturnValue());

   }
      else{
          console.log("cas Failed with state: " + state);
      }
  });
  $A.enqueueAction(loadHeader);
 },
 
})