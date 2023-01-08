using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UIHideOnClick : MonoBehaviour, IPointerDownHandler
{
    [SerializeField] private float delayHide;

    private bool isAlreadyHiding;



    public void OnPointerDown(PointerEventData eventData)
    {
        if (isAlreadyHiding)
            return;

        StartCoroutine(HideUICoroutine());
    }

    private IEnumerator HideUICoroutine()
    {
        // Unblock click
        gameObject.GetComponent<Image>().raycastTarget = false;
        // Delay some sec
        yield return new WaitForSeconds(delayHide);
        // Then hide UI
        gameObject.SetActive(false);
    }
}