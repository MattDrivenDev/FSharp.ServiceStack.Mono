namespace FSharp.WebApi

    open HelloService
    open System.Web

    type Global() =
        inherit HttpApplication()        
        member this.Start() = 
            let helloServiceHost = new HelloServiceHost()
            helloServiceHost.Init()