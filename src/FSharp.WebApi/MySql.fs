module MySql

    open FsSql
    open System.Data

    let openConnection = 
        let connection = new MySql.Data.MySqlClient.MySqlConnection("Server=localhost;Uid=servicestack;Pwd=servicestackpw;Database=servicestackdb;")
        connection.Open()
        connection :> IDbConnection

    let connectionManager = Sql.withConnection openConnection

    let execNonQuery sql p = Sql.execNonQuery connectionManager sql p |> ignore

    let P = Sql.Parameter.make