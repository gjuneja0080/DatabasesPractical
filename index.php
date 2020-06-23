<html>
<head>
<style>

form {
    background-color: #3498DB;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
    display: block;
    margin-top: 1em;
}


    form:hover, form:focus {                                         /*Dropdown button on hover & focus*/ 
        background-color: #2980B9;
    }
    table {                                                          /*Setting the width and border of the table*/
    width: 100%;
    border-collapse: collapse;
    }

    table, td, th {                                                 /*Primarily setting the border and padding around table data and table header*/            
    border: 1px solid black;
    padding: 5px;
    }

    th, td {                                                         /*Primarily making the bottom and the top border of the table header and the table data invisiblle*/   
    border-bottom: 0px solid #ddd;
    border-top: 0px solid #ddd;
    }

    tr:nth-child(even) {background-color: DodgerBlue;}               /*Setting the even rows in the table to the colour DodgerBlue*/   
    tr:nth-child(odd) {background-color: DodgerBlue;}                /*Setting the odd rows in the table to the colour DodgerBlue*/  

    th {
    background-color: #333B87;                                       /*Assigning the background colour of the table header*/                   
    color: white;
    }

    tr:hover {background-color: #4073C1;}                             /*Assigns a different colour to the table row when the cursor is hovering over the table row*/  

    th {text-align: left;}                                            /*Aligns the text in the table header to left*/

    body{
        background-image: url(https://www.booktrust.org.uk/globalassets/images/illustrations/fiona-lumbers-3-4/jpegs/fiona-lumbers-best-new-books-16x9.jpg?preset=16x9_tablet_one_half&anchor=middlecenter);                            /*Makes the background of the website to an image that can be accessed via the url*/
        background-repeat: repeat;                                                                                                                                                                                                          
        background-attachment: fixed;

    }
  
    </style>
        <font size ='7'>BookStream</font><br>
        <font size = '4'><b>View the list of audiobooks and the currently available audiobook reviews here!</b></font>
    <?php

        $connection = mysqli_connect('gj25.host.cs.st-andrews.ac.uk','gj25','e9.48J1P1rF5Ve','gj25_dbPrac');           /*Connecting to database by giving the right hostname, user, password and database name */ 
        if (!$connection) {                                                                                            /*Throws an error if connection cannot be established*/        
            die('Could not connect to database: ' . mysqli_error($connection));                                                                 
        }
        mysqli_select_db($connection,"ajax_demo");                                                                     /*Selects the default database for database queries */                                                                    
        $sqlquery="SELECT title, ISBN from audiobook";                                                                           
        $output = mysqli_query($connection,$sqlquery);                                                                 /* Performing the sql query stored in $sqlquery against the connected database */                                                                        
        echo "<form>";                                                                                                 /* HTML commands to make a dropdown menu */                                                                      
        echo "<select name=\"users\" onchange=\"showUSR(this.value)\">";
        echo"<option value=\"\">Select audiobook for the review:</option>";
        while($res = mysqli_fetch_array($output)) {                                                                    /*Loop to go iterate through the output of the sql query to add the right title of the audibook in the dropdown menu*/
            echo"<option value=\"".$res['ISBN']."\">".$res['title']."</option>"; 
        }
        echo"</select>";
        echo"</form>";
        echo"<br>";

        mysqli_close($connection);                                                                                      /*Closes the connection to the database */
    ?> 
                
<script>
    function showUSR(str) {                                                                                                            
        if (str == "") {
            document.getElementById("txtHint").innerHTML = "";                                                                         
            return;
        }else{ 
                if (window.XMLHttpRequest) {                                                                            /*code for all modern web browsers*/                                                                                                                                       
                  xmlhttp = new XMLHttpRequest();                                                                       /* Creating an XMLHttpRequest object */
                }
                xmlhttp.onreadystatechange = function() {                                                               /* function() is called whenever the readystate property of xmlhttp changes */
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {                                             /* When readyState property is 4 and the status property is 200, the response is ready to with no issues in the connectivity between the web browser and the web server */                                          
                        document.getElementById("txtHint").innerHTML = xmlhttp.responseText;                            /*Changes the html version of the element "txtHint" with the response recieved from the server */
                    }                                                                   
                };
                xmlhttp.open("GET","phpscript.php?q="+str,true);                                                        /*This is used to make a GET request to the other php file phpscript.php*/                                                                                                                                 
                xmlhttp.send();
            }           
    }
</script>
</head>
<body>
<div id="txtHint"><b></b></div>
</body>

</html>