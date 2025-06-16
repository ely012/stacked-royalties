;; ------------------------------------------------------------
;; Contract: stacked-royalties
;; Purpose: Automate royalty distribution on asset sales
;; Author: [Your Name]
;; ------------------------------------------------------------

(define-constant ERR_NOT_FOUND (err u100))
(define-constant ERR_UNAUTHORIZED (err u101))
(define-constant ERR_ALREADY_EXISTS (err u102))
(define-constant ERR_INVALID_RATE (err u103))

;; Asset ID could be a principal, or token-id if using SIP-009 NFT standard
(define-map royalty-rules
  principal
  {
    recipient: principal,
    rate: uint ;; expressed in basis points (e.g. 500 = 5%)
  }
)

;; === Register a new royalty rule ===
(define-public (register-royalty (asset-id principal) (recipient principal) (rate uint))
  (begin
    (asserts! (<= rate u10000) ERR_INVALID_RATE) ;; max 100%
    (match (map-get? royalty-rules asset-id)
      existing-rule
      ERR_ALREADY_EXISTS
      (begin
        (map-set royalty-rules asset-id {
          recipient: recipient,
          rate: rate
        })
        (ok true)
      )
    )
  )
)

;; === Update existing royalty rule ===
(define-public (update-royalty (asset-id principal) (new-recipient principal) (new-rate uint))
  (begin
    (asserts! (<= new-rate u10000) ERR_INVALID_RATE)
    (match (map-get? royalty-rules asset-id)
      rule
      (if (is-eq asset-id tx-sender) ;; only the asset owner can update
          (begin
            (map-set royalty-rules asset-id {
              recipient: new-recipient,
              rate: new-rate
            })
            (ok true)
          )
          ERR_UNAUTHORIZED
      )
      ERR_NOT_FOUND
    )
  )
)

;; === Revoke royalty rule ===
(define-public (revoke-royalty (asset-id principal))
  (match (map-get? royalty-rules asset-id)
    rule
    (if (is-eq asset-id tx-sender)
        (begin
          (map-delete royalty-rules asset-id)
          (ok true)
        )
        ERR_UNAUTHORIZED
    )
    ERR_NOT_FOUND
  )
)

;; === Execute royalty payment ===
(define-public (pay-royalty (asset-id principal) (amount uint))
  (match (map-get? royalty-rules asset-id)
    rule
    (let ((royalty-amount (/ (* amount (get rate rule)) u10000)))
      (ok (stx-transfer? royalty-amount tx-sender (get recipient rule)))
    )
    ERR_NOT_FOUND
  )
)
