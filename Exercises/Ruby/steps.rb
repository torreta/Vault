# TODO REHACER ESTE CONTROLADOR PARA QUE SEA MAS FACIL Y CONCISO


		# 1. cambio los datos del formulario que no van a variar a grandes rasgos 

		# 1. The update function is checking whether the form has been submitted by looking at the params hash. It starts by checking if params[:commit] is present. If it is, it means the form has been submitted.

		# 2. he function then initializes a few variables, like i, j, k, array, array_schedule_app, array_hours, delete_addresses, delete_business_hours, address_id, header, @ids_addresses, @ids_business_hours, @address, @busi, @delete_business_hour_result, and @delete_address_result.
		
		# 3. It then enters a loop that iterates over the addresses in the form. For each address, it does the following:
		
		# a. Checks if the address already exists by looking at params["idC#{i}"]. If it does, it means the address is being updated, not created.
		
		# b. If the address is being updated, it gets its ID and retrieves the existing address and business hours from the database.
		
		# c. It then enters a loop that iterates over the business hours for each address. For each business hour, it does the following:
		
		# i. Checks if the business hour is being deleted by looking at params["deleteC#{j}#{k}"]. If it is, it deletes the business hour.
		
		# ii. If the business hour is not being deleted, it updates the business hour with the new information from the form.
		
		# d. After all business hours have been updated, it enters a loop that iterates over the new business hours in the form. For each new business hour, it does the following:
		
		# i. Checks if the new business hour is being added by looking at params["newC#{j}#{k}"]. If it is, it creates the new business hour.
		
		# ii. It then creates a new business hour with the information from the form.
		
		# 4. After all addresses and business hours have been updated or created, it enters a loop that deletes any extra addresses or business hours that were removed from the form.
		
		# 5. Finally, it redirects the user to the edit page with a success message.


		# ----------------------------------------

		# 1. The function first retrieves necessary parameters such as 'CMP', 'RNE', 'numOfstudies', 'services' from the input and constructs a new JSON object with these parameters.

		# 2. The function then constructs a URL to the medical profile of a specific provider and makes a PUT HTTP call to this URL with the constructed JSON object to update the medical profile of the provider.
		
		# 3. It logs the result of the HTTP call for debugging purposes.
		
		# 4. The function then retrieves the number of consulting rooms from the input and iterates over each consulting room.
		
		# 5. It retrieves the address and business hours of each consulting room from the input.
		
		# 6. If the address ID exists, the function updates the address and business hours of the consulting room by making PUT and DELETE HTTP calls respectively.
		
		# 7. If the address ID does not exist, the function creates a new address and business hours for the consulting room by making POST HTTP calls.
		
		# 8. After updating all consulting rooms, the function then retrieves the IDs of the addresses and business hours that need to be deleted.
		
		# 9. It iterates over each address ID and deletes the corresponding address and business hours by making DELETE HTTP calls.
		
		# 10. Finally, the function redirects to the 'edit' action with a status indicating a successful update of the medical profile.
		
		
		# =======================================================
		
		# 1. Check if the form is valid.
		
		# 2. If the form is not valid, return to the edit page with an error message.
		
		# 3. Iterate over each address in the form.
		# 	- If the address is new, create a new address and business hours.
		# 	- If the address is not new, update the existing address and business hours.
		
		# 4. For each address, iterate over each business hour.
		# 	- If the business hour is new, create a new business hour.
		# 	- If the business hour is not new, update the existing business hour.
		
		# 5. If there are any errors during the creation or update of addresses or business hours, return to the edit page with an error message.
		
		# 6. After all addresses and business hours have been updated, redirect to the edit page with a success message.
		
		