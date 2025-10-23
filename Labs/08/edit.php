<?php
include("php/query.php");
?>

<!doctype html>
<html lang="en">
  <head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  </head>
  <body>
    <?php
        if (isset($_GET['std_id'])) {
          $std_id = $_GET['std_id'];
          $query = $pdo->prepare('SELECT * FROM student WHERE std_id = :std_id');
          $query->bindParam('std_id', $std_id);
          $query->execute();
          $student = $query->fetch(PDO::FETCH_ASSOC);
        }
    ?>
    <div class="container p-5">
        <a href="select.php">View</a>
        <form action="" method="post" enctype="multipart/form-data">
            <div class="form-group">
              <label for="first_name">First Name</label>
              <input type="text" name="first_name" id="first_name" class="form-control" value="<?php echo $student['first_name'] ?>" placeholder="John" aria-describedby="helpId">
              <small id="helpId" class="text-danger"><?php echo $firstNameErr ?></small>
            </div>
            <div class="form-group">
              <label for="last_name">Last Name</label>
              <input type="text" name="last_name" id="last_name" class="form-control" value="<?php echo $student['last_name'] ?>" placeholder="Doe" aria-describedby="helpId">
              <small id="helpId" class="text-danger"><?php echo $lastNameErr ?></small>
            </div>
            <div class="form-group">
              <label for="age">Age</label>
              <input type="text" name="age" id="age" class="form-control" placeholder="69" value="<?php echo $student['age'] ?>" aria-describedby="helpId">
              <small id="helpId" class="text-danger"><?php echo $ageErr ?></small>
            </div>
            <div class="form-group">
              <label for="image">Image</label>
              <input type="file" name="image" id="image" class="form-control" placeholder="" value="<?php echo $student['image'] ?>" aria-describedby="helpId">
              <small id="helpId" class="text-danger"><?php echo $imageErr ?></small>
            </div>

            <button type="submit" name="updateStudent" class="btn btn-primary">Update</button>
        </form>
    </div>
  </body>
</html>