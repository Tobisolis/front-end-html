<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicial</title>
    <style>

            .mainindex{
                
                padding: 50px;

            }

           .headerindex{

              margin: 20px;
              background-color: black;
              display: grid;
              grid-template-rows: 30% 1fr;
           }

           .h1index{

            font-size: 60px;
            font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
            color: white;
            text-align: center;
            text-transform: uppercase;
           }

           .divindex{
              
             display: grid;
             grid-template-columns: 1fr 1fr 1fr 1fr;
           }

           .tamano{

               width: 290px;
               height: 310px;
               margin-left: 10px;
           }

           .s1ndex{

             background-image: url("./img/moda1.jpg");
         
           }

           /********************************************/
           *{box-sizing:border-box;}

            form{
                width:700px;
                padding:16px;
                border-radius:10px;
                margin:auto;
                background-color:#ccc;
            }

            form label{
                width:72px;
                font-weight:bold;
                display:inline-block;
            }

            form input[type="text"],
            form input[type="password"]{
                width:660px;
                padding:10px 17px;
                border:1px solid #f6f6f6;
                border-radius:3px;
                background-color:#f6f6f6;
                margin:8px 0;
                display:grid;
                grid-template-rows: 1fr 1fr;
            }

            form input[type="submit"]{
                width:100%;
                padding:8px 16px;
                margin-top:32px;
                border:1px solid #000;
                border-radius:5px;
                display:block;
                color:#fff;
                background-color:#000;
            } 

            form input[type="submit"]:hover{
                cursor:pointer;
            }

            form a[type="submit"]{
                width:100%;
                padding:8px 16px;
                margin-top:32px;
                border:1px solid #000;
                border-radius:5px;
                display:block;
                color:#fff;
                background-color:#000;
            } 

            form a[type="submit"]:hover{
                cursor:pointer;
            }

           /*******************************************/
           

    </style>
</head>
<body>


        <header class="headerindex">
                  <h1 class="h1index"> welcome , tiendas meraki</h1>
                  <div class="divindex">
                    <img src="./img/moda4.jpg" alt="Loading..." class="tamano">  
                    <img src="./img/moda.jpg" alt="Loading..." class="tamano"> 
                    <img src="./img/moda2.jpg" alt="Loading..." class="tamano">
                    <img src="./img/moda3.jpg" alt="Loading..." class="tamano">
                  </div>
        </header>

        <main class="mainindex">

            <section class="s1ndex">
                <form action="./pages/principal.php" target="" method="get" name="formDatosPersonales">

                    <label for="nombre">Nombre</label>
                    <input type="text" name="nombre" id="nombre" placeholder="Escribe tu nombre"/>
                
                    <label for="clave">Contrase??a</label>
                    <input type="password" name="clave" id="clave" placeholder="marki1"/>
                    
                    <input type="submit" name="enviar" value="Iniciar"/>
                </form>

            </section>

        </main>
    
</body>
</html>