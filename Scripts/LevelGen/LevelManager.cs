using Godot;
using System;

public class LevelManager : Node2D
{
    [Export] public Vector2 mapSize;
    [Export] public int countDownDuration;
    [Export] public string countDownTime;
    [Export] public NodePath enemyManagerPath;
    public Node2D enemyManager;
    [Export] public NodePath playerPath;
    public Node2D player;

    public static bool levelWon = false;
    public static bool gameOver = false;
    //public GDScript Enemy = ResourceLoader.Load<GDScript>("res://Scripts/Gameplay/Enemies/Enemy.gd");
    float startingTime;
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
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
        float countDown = (countDownDuration - timesec);

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
    public void LevelWon()
    {
        levelWon = true;
        GD.Print("LevelWon");
        enemyManager.Call("StopEnemies");
        player.Set("playerDisabled", true);

    }
    public static void GameOver()
    {
        if (gameOver == true)
        {
            return;
        }
        gameOver = true;
        GD.Print("you have lost the game");
    }
}
