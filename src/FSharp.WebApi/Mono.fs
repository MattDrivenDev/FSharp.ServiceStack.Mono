module Mono

    open System

    type MonoStrictMsCompliant = | Yes | No
    let ensureStrictMsCompliant x =
        match x with
        | Yes -> Environment.SetEnvironmentVariable("MONO_STRICT_MS_COMPLIANT", "yes")
        | No -> Environment.SetEnvironmentVariable("MONO_STRICT_MS_COMPLIANT", "no")