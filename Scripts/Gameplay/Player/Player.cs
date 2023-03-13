using Godot;

public class Player : KinematicBody2D
{
    [Export] private readonly float _acceleration;
    [Export] private readonly float _maxVelocity;
    [Export] private readonly float _drag;
    [Export] private readonly bool _debugInfo;
    [Export] private readonly PackedScene _projectile;
    [Export] private float _hp;
    [Export] public readonly float maxHp;

    [Export] public float shootDelay;
    // Debug Stuff
    private Label _velocityLabel;
    private Line2D _mouseLine;
    // -----------

    private Vector2 _inputVector = Vector2.Zero;
    public Vector2 velocity = Vector2.Zero;
    private Vector2 _mouseDirection = Vector2.Zero;
    public float _mouseAngle;
    float _lastTimeShot = 0;
    public bool playerDisabled = false;
    #region Godot Methods
    public override void _Ready()
    {
        _velocityLabel = GetNode<Label>("Debug/Velocity");
        _mouseLine = GetNode<Line2D>("Debug/MouseLine");

        _hp = maxHp;
    }

    public override void _Process(float delta)
    {
        if (playerDisabled == true)
        {
            velocity = Vector2.Zero;
            return;
        }
        FetchInput();
        CalculateVelocity();
        _mouseAngle = CalculateMouseAngle();

        ShowDebugInfo();
    }

    public override void _PhysicsProcess(float delta) => HandleMovement();

    #endregion

    #region Movement and Shooting
    private void FetchInput()
    {
        _inputVector = Vector2.Zero;

        _inputVector.x = Input.IsActionPressed("MoveLeft") ? -1.0f : _inputVector.x;
        _inputVector.x = Input.IsActionPressed("MoveRight") ? 1.0f : _inputVector.x;

        _inputVector.y = Input.IsActionPressed("MoveUp") ? -1.0f : _inputVector.y;
        _inputVector.y = Input.IsActionPressed("MoveDown") ? 1.0f : _inputVector.y;

        if (Input.IsActionPressed("Fire") && (Time.GetTicksMsec() - _lastTimeShot > shootDelay))
        {
            _lastTimeShot = Time.GetTicksMsec();
            FireProjectile();
        }
    }

    private void HandleMovement() => MoveAndSlide(velocity);

    private void FireProjectile()
    {


        Projectile p = _projectile.Instance<Projectile>();

        p.Init(Position + (_mouseDirection.Normalized() * 10.0f), CalculateMouseAngle());
        GetTree().Root.AddChild(p);
    }
    #endregion

    #region Calculations
    private void CalculateVelocity()
    {
        velocity = new Vector2(Mathf.Clamp(velocity.x, -_maxVelocity, _maxVelocity),
            Mathf.Clamp(velocity.y, -_maxVelocity, _maxVelocity));

        velocity += _inputVector.Normalized() * _acceleration * GetPhysicsProcessDeltaTime();

        if (_inputVector.y == 0)
        {
            velocity.y = ApplyDrag(ref velocity.y);
        }

        if (_inputVector.x == 0)
        {
            velocity.x = ApplyDrag(ref velocity.x);
        }
    }

    private float ApplyDrag(ref float coord)
    {
        /*velocity.x = Mathf.MoveToward(velocity.x, 0.0f, _drag * GetProcessDeltaTime());
        velocity.y = Mathf.MoveToward(velocity.y, 0.0f, _drag * GetProcessDeltaTime());*/

        return Mathf.MoveToward(coord, 0.0f, _drag * GetProcessDeltaTime());
    }

    private float CalculateMouseAngle()
    {
        _mouseDirection = GetGlobalMousePosition() - Position;

        float angleRads = Mathf.Atan2(_mouseDirection.y, _mouseDirection.x);
        float angleDegs = Mathf.Rad2Deg(angleRads);

        // 90 Degree offset is necessary to get the correct angle
        return angleDegs + 90.0f;
    }
    #endregion

    private void ShowDebugInfo()
    {
        if (!_debugInfo) return;

        _velocityLabel.Text = "Velocity: " + velocity.ToString("0.0");
        _mouseLine.SetPointPosition(1, _mouseDirection.Normalized() * 10.0f);
    }
    // public void AimGun()
    // {

    //     _mouseAngle
    // }
    public void reciveDmg(float dmg)
    {
        _hp = _hp - dmg;
        if (_hp <= 0)
        {
            LevelManager.GameOver();
        }
    }
}
