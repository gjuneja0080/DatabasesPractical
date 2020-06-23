<!DOCTYPE html>
<html>

<body>
<?php
$q = $_GET['q'];                                                                                        /* Variable that is used further down in the code to get the ISBN of audiobook */

$con = mysqli_connect('gj25.host.cs.st-andrews.ac.uk','gj25','e9.48J1P1rF5Ve','gj25_dbPrac');           /* Connection to the database is being made here */        
if (!$con) {
    die('Could not connect to database: ' . mysqli_error($con));
}

mysqli_select_db($con,"ajax_demo");
$sql="SELECT title, comment, rating FROM audiobook_reviews where audiobook_reviews.ISBN = '".$q."'";        
$result = mysqli_query($con,$sql);
                                                                                                        /*HTML commands to create table with columns title, comment and rating respectively, under which reviews for table is displayed */
echo "<table>                                                                                                       
<tr>
<th>Title</th>
<th>Comment</th>
<th>Rating</th>
</tr>";
while($row = mysqli_fetch_array($result)) {                                                             /* This loop is used to fill out the audiobook reviews that is stored in the $result variable, which is implementing the query that it gets from the databsase */
    echo "<tr>";
    echo "<td>" . $row['title'] . "</td>";
    echo "<td>" . $row['comment'] . "</td>";
    echo "<td>" . $row['rating'] . "</td>";
    echo "</tr>";
}

echo "</table>";
mysqli_close($con);
?>
</body>
</html>