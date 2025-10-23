<?php
include("php/query.php");
?>

<!doctype html>
<html lang="en">
  <head>
    <title>Select</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  </head>
  <body>
    <div class="container">
        <a href="add.php" class="mb-5">Add</a>
        <table class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Age</th>
                    <th>Image Src</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $query = $pdo->query("SELECT * FROM student");
                $students = $query->fetchAll(PDO::FETCH_ASSOC);
                foreach ($students as $std) {
                ?>
                    <tr>
                        <td><?php echo $std['std_id'] ?></td>
                        <td><?php echo $std['first_name'] ?></td>
                        <td><?php echo $std['last_name'] ?></td>
                        <td><?php echo $std['age'] ?></td>
                        <td><image alt="noimage" src="<?php echo $std['image'] ?>" /></td>
                        <td><a href="edit.php?std_id=<?php echo $std['std_id'] ?>">Edit<a></td>
                        <td><a href="select.php?d_std_id=<?php echo $std['std_id'] ?>">Delete<a></td>
                    </tr>
                <?php
                }
                ?>
            </tbody>
        </table>
    </div>
  </body>
</html>