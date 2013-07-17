module HelloService

    open ServiceStack.ServiceHost
    open ServiceStack.WebHost.Endpoints
    open ServiceStack.ServiceInterface


    [<CLIMutable>]
    type HelloResponse = { Text : string }


    [<Route("/hello", "GET")>]
    type HelloRequest() = 
        interface IReturn<HelloResponse>


    type HelloService() =
        inherit Service()

        let saveAndRespond response = 
            MySql.execNonQuery 
                "insert into Helloworld (ResponseText) values (@responseText)"
                [MySql.P("@responseText", response.Text)]
            response

        member this.Get(helloRequest: HelloRequest) = 
            { Text = "Hello, world!" }
            |> saveAndRespond


    type HelloServiceHost() = 
        inherit AppHostBase("Hello Service", typeof<HelloService>.Assembly)
        override this.Configure container = 
            container |> ignore