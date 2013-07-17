namespace FSharp.WebApi

    open Mono
    open HelloService
    open System.Web

    type Global() =
        inherit HttpApplication()        
        member this.Start() = 
            
            ensureStrictMsCompliant Yes

            let helloServiceHost = new HelloServiceHost()
            helloServiceHost.Init()