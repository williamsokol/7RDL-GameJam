using Godot;
using System;

public class LevelManager : Node2D
{
    // Settings
    [Export] public Vector2 mapSize;

    // References
    [Export] public NodePath enemyManagerPath;
    public Node2D enemyManager;
    [Export] public NodePath playerPath;
    [Export] public PackedScene GameOverScene;
    [Export] public PackedScene GameEndingScene;
    public Node2D player;

    // Globals
    [Export] public int countDownDuration;
    [Export] public string countDownTime;
    public static bool levelWon = false;
    public static bool gameOver = false;
    public float countDown;

    public static LevelManager instance;
    //public GDScript Enemy = ResourceLoader.Load<GDScript>("res://Scripts/Gameplay/Enemies/Enemy.gd");
    float startingTime;
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        if (instance != null)
        {
            instance = null;
            //instance.QueueFree();

        }
        instance = this;
        levelWon = false;
        gameOver = false;
        if (enemyManagerPath != null)
            enemyManager = (Node2D)GetNode(enemyManagerPath);
        if (playerPath != null)
            player = (Node2D)GetNode(playerPath);
        //Enemy a = 1;
        mapSize = GetViewportRect().Size;
        GD.Print("ready");
        startingTime = Time.GetTicksMsec();

    }

    //  // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(float delta)
    {
        if (levelWon == true)
        {
            return;
        }
        float timesec = ((Time.GetTicksMsec() - startingTime) / 1000);
        countDown = (countDownDuration - timesec);

        if (countDown <= 0)
        {
            if (enemyManager != null)
            {
                LevelWon();

            }
        }
        else
        {
            int sec = (int)(countDown % 60);
            int min = (int)(countDown / 60);
            countDownTime = min.ToString("00") + ":" + sec.ToString("00");
        }


    }
    public async void LevelWon()
    {
        if (gameOver == true)
        {
            return;
        }
        levelWon = true;
        GD.Print("LevelWon");
        enemyManager.Call("StopEnemies");
        player.Set("playerDisabled", true);

        await ToSignal(GetTree().CreateTimer(2), "timeout");
        var gameManager = (Node)GetNode("/root/GameManager");
        gameManager.Call("TransitionScene", GameEndingScene);


    }
    public void GameOver()
    {
        if (gameOver == true || levelWon == true)
        {
            return;
        }
        gameOver = true;

        //enemyManager.Call("StopEnemies");
        player.Set("playerDisabled", true);
        GD.Print("you have lost the game");
        var gameManager = (Node)GetNode("/root/GameManager");
        gameManager.Call("TransitionScene", GameOverScene);
    }
}
