#!/bin/sh

input_invoices_Z="";

output_report_Z="";

parse_file()
{	
	echo -n ";" > file1.csv
	sed  's/\r//g' $1 >> file1.csv
	sed  's/\t//g'  file1.csv > file2.csv
	sed  's/\./,/g'  file2.csv > $2
	rm file1.csv file2.csv
}


add_attribute(){
	report_z=parsed_report_Z
	check_attribute=1
	current_invoice=0
	invoice="FACTURA:"
	index=$4
	index_value=$5
	skip=0
	sed  's/\r//g' $1 >> $report_z
	echo "Invoice: $2 $3 $4 $5"
	while IFSX='' read -r linex ; do
		# # Found an Invoice Block
		# if [  $check_attribute = 0 ] ; then 
		# 	echo $linex > current_line.csv
		# 	current_attribute=$(awk  '{ print $1}' current_line.csv)

		# 	if [ $current_attribute = $invoice ] ; then 
		# 		check_attribute=1;
		# 		echo "Found Invoice Block"

		# 	fi
		# fi
		# Check if Invoice Block is the invoice to be checked
		if [ $check_attribute = 1 ] ; then 
			echo $linex > current_line.csv
			current_invoice=$(awk  '{ print $2}' current_line.csv)
			current_attribute=$(awk  '{ print $1}' current_line.csv)
			if [ "$current_invoice" = "$2" ] &&  [ "$current_attribute" = "$invoice" ] ; then 
				echo "Found Invoice: $current_invoice-$2"
				check_attribute=2
				skip=1;

			fi
		fi

		# Check if Invoice Block has the attribute
		if [ $check_attribute = 2 ] ; then 
			echo $linex > current_line.csv
			current_attribute=$(awk  ' { print '$index' }' current_line.csv)
			break_attribute=$(awk  ' { print $1 }' current_line.csv)
			if [ $skip = 0 ] ; then
				if [ "$break_attribute" = "$invoice" ] ; then 
					output_report_Z=$output_report_Z";0"
					echo "Attribute Not Found"
					break
				fi
			fi 
			if [ "$current_attribute" = "$3" ] ; then 
				attribute_value=$(awk '{ print '$index_value' }' current_line.csv) 
				output_report_Z=$output_report_Z";$attribute_value"
				echo "Found Attribute: $attribute_value"
				break
			fi
			skip=0
		fi

		rm current_line.csv

	done < "$report_z"



}


create_invoice_total(){
	report_z=parsed_report_Z
	check_attribute=1
	current_invoice=0
	invoice="FACTURA:"
	index=$4
	index_value=$5
	skip=0
	sed  's/\r//g' $1 >> $report_z
	echo "Invoice: $2 $3 $4 $5"
	while IFSX='' read -r linex ; do
		# Check if Invoice Block is the invoice to be checked
		if [ $check_attribute = 1 ] ; then 
			echo $linex > current_line.csv
			current_invoice=$(awk  '{ print $2}' current_line.csv)
			current_attribute=$(awk  '{ print $1}' current_line.csv)
			if [ "$current_invoice" = "$2" ] &&  [ "$current_attribute" = "$invoice" ] ; then 
				echo "Found Invoice: $current_invoice-$2"
				check_attribute=2
				skip=1;

			fi
		fi

		# Check if Invoice Block has the attribute
		if [ $check_attribute = 2 ] ; then 
			echo $linex > current_line.csv
			current_attribute=$(awk  ' { print '$index' }' current_line.csv)
			break_attribute=$(awk  ' { print $1 }' current_line.csv)
			if [ $skip = 0 ] ; then
				if [ "$break_attribute" = "$invoice" ] ; then 
					input_invoices_Z=$input_invoices_Z";0"
					echo "Attribute Not Found"
					break
				fi
			fi 
			if [ "$current_attribute" = "$3" ] ; then 
				attribute_value=$(awk '{ print '$index_value' }' current_line.csv) 
				input_invoices_Z=$input_invoices_Z";$attribute_value"
				echo "Found Attribute: $attribute_value"
				break
			fi
			skip=0
		fi

		rm current_line.csv

	done < "$report_z"



}



validate_invoices()
{	
	sed  's/\r//g' $1 >> file1.txt
	sed  's/\./,/g'  file1.txt > file2.txt
    awk '{ if ($1 == "FACTURA:")  printf("%5s\n", $2) } ' file2.txt > file3.txt

   	touch total.csv


   	while IFS='' read -r line ; do

   		echo $line > current.csv

   		current_invoice=$(awk  '{ print $1}' current.csv)

        input_invoices_Z=$current_invoice
        

    	create_invoice_total $1 $current_invoice "TOTAL" "\$1" "\$3" 
    

    	echo $input_invoices_Z >> total.csv

   	done < file3.txt


	rm file1.txt file2.txt file3.txt
    
}


create_reportZ()
  {
	exempted="EXENTO"
	exempted_index="\$1"
	exempted_value="\$3"

	biiva="BIG16,00%"
	biiva_index="\$1\$2"
	biiva_value="\$4"
	biiva_value_amount="\$8"

	biigtf="BIIGTF3,00%"
	biigtf_index="\$1\$2"
	biigtf_value="\$4"
	biigtf_value_amount="\$7"

	total="TOTAL"
	total_index="\$1"
	total_value="\$3"



	qty=0
	original_Z=$1
	validate_invoices $1
    parsed_invoices=total.csv

	touch output_file.csv
	echo "FACTURA;BIIVA;IVA;BIIGTF;EXENTO;TOTAL" > output_file.csv
	counter=1
	echo "File: $2"
	initial="$(wc -l $parsed_invoices | awk '{print $1}')"
	echo "******** $input_file *********"
	echo  "Initial Count: $initial"
	while IFS='' read -r line ; do
		echo $line > current.csv
		current_invoice=$(awk -F";" '{ print $1}' current.csv)
		output_report_Z=$current_invoice

		add_attribute $original_Z $current_invoice $biiva $biiva_index $biiva_value 
		add_attribute $original_Z $current_invoice $biiva $biiva_index $biiva_value_amount

		add_attribute $original_Z $current_invoice $biigtf $biigtf_index $biigtf_value
		add_attribute $original_Z $current_invoice $biigtf $biigtf_index $biigtf_value_amount


		add_attribute $original_Z $current_invoice $exempted $exempted_index $exempted_value

		add_attribute $original_Z $current_invoice $total $total_index $total_value

		output_report_Z=$output_report_Z
		echo $output_report_Z >> output_file.csv

	done < "$parsed_invoices"
	final_count="$(wc -l $parsed_invoices)"
	echo  "Initial Count: $final_count"
  }

create_reportZ $1
