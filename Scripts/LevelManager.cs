using Godot;
using System;

public class LevelManager : Node2D
{
    [Export]
    public Vector2 mapSize;
    [Export]
    public int countDownDuration;
    [Export]
    public string countDownTime;

    float startingTime;
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        mapSize = GetViewportRect().Size;
        GD.Print("ready");
        startingTime = Time.GetTicksMsec();

    }

    //  // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(float delta)
    {
        float timesec = ((Time.GetTicksMsec() - startingTime) / 1000);
        float countDown = (countDownDuration - timesec);

        if (countDown <= 0)
        {
            LevelWon();
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
        GD.Print("LevelWon");
    }
}
