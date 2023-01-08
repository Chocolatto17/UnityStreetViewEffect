using UnityEngine;
using UnityEngine.UI;

public class UIButtonNavigate : MonoBehaviour
{
    [Header("UI Comps")]
    [SerializeField] private UIButtonNavigate[] buttonNavigatesToShowAfterNavigating;
    [SerializeField] private bool isTransitionFromPanorama1ToPanorama2;

    [Header("Other Ref")]
    [SerializeField] private StreetViewSphere streetViewSphere;

    private Button buttonNavigate;



    void Awake()
    {
        buttonNavigate = GetComponent<Button>();
        buttonNavigate.onClick.AddListener(OnButtonNavigate_Clicked);
    }

    private void OnButtonNavigate_Clicked()
    {
        gameObject.SetActive(false);
        EnableOtherButtonNavigate();

        Vector3 distortionDirection = transform.position;
        streetViewSphere.StartTransition(isTransitionFromPanorama1ToPanorama2, distortionDirection);
    }

    private void EnableOtherButtonNavigate()
    {
        for (int i = 0; i < buttonNavigatesToShowAfterNavigating.Length; i++)
            buttonNavigatesToShowAfterNavigating[i].gameObject.SetActive(true);
    }
}