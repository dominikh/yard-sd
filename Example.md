Input:

    !!!plain
    !!!sd
    % size = 800

    thread SimulationServer as SiS
    participant SimControlNode as SCN
    participant PhysicsServer as PS
    participant[2] SenseServer as SeS

    SiS->SeS: Initialize()
    SeS-->SiS:

    block "Run Loop" "The main loop"
      SiS->SCN: StartCycle()
      SCN->SeS: ActAgent()
      SeS-->SCN:
      SCN-->SiS:

      SiS->PS: Update()
      PS->SeS: PrePhysicsUpdate
      noreturn

      PS->PS: PhysicsUpdate()
      PS-->PS:

      PS->SeS: PostPhysicsUpdate()
      SeS-->PS:

      PS-->SiS:

      SiS->SCN: EndCycle()
      SCN->SeS: SenseAgent()
      SeS-->SCN:
      SCN-->SiS:

Output:

    !!!sd
    % size = 800

    thread SimulationServer as SiS
    participant SimControlNode as SCN
    participant PhysicsServer as PS
    participant[2] SenseServer as SeS

    SiS->SeS: Initialize()
    SeS-->SiS:

    block "Run Loop" "The main loop"
      SiS->SCN: StartCycle()
      SCN->SeS: ActAgent()
      SeS-->SCN:
      SCN-->SiS:
      SiS->SCN: Something
      SCN-->SiS: Something else

      SiS->PS: Update()
      PS->SeS: PrePhysicsUpdate
      noreturn

      PS->PS: PhysicsUpdate()
      PS-->PS:

      PS->SeS: PostPhysicsUpdate()
      SeS-->PS:

      PS-->SiS:

      SiS->SCN: EndCycle()
      SCN->SeS: SenseAgent()
      SeS-->SCN:
      SCN-->SiS:
