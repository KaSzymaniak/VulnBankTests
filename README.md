# Penetration Testing - VulnBank

## 1. Authentication & Authorization

- [ ] SQL Injection in login
- [ ] Weak JWT implementation
- [ ] Broken object level authorization (BOLA)
- [ ] Broken object property level authorization (BOPLA)
- [ ] Mass Assignment & Excessive Data Exposure
- [ ] Weak password reset mechanism (3-digit PIN)
- [ ] Token stored in localStorage
- [ ] No server-side token invalidation
- [ ] No session expiration

---

## 2. Data Security

- [ ] Information disclosure
- [ ] Sensitive data exposure
- [ ] Plaintext password storage
- [ ] SQL injection points
- [ ] Debug information exposure
- [ ] Detailed error messages exposed

---

## 3. Transaction Vulnerabilities

- [ ] No amount validation
- [ ] Negative amount transfers possible
- [ ] No transaction limits
- [ ] Race conditions in transfers and balance updates
- [ ] Transaction history information disclosure
- [ ] No validation on recipient accounts

---

## 4. File Operations

- [ ] Unrestricted file upload
- [ ] Path traversal vulnerabilities
- [ ] No file type validation
- [ ] Directory traversal
- [ ] No file size limits
- [ ] Unsafe file naming
- [ ] Server-Side Request Forgery (SSRF) via URL-based profile image import

---

## 5. Session Management

- [ ] Token vulnerabilities
- [ ] No session expiration
- [ ] Weak secret keys
- [ ] Token exposure in URLs

---

## 6. Client and Server-Side Flaws

- [ ] Cross Site Scripting (XSS)
- [ ] Cross Site Request Forgery (CSRF)
- [ ] Insecure direct object references
- [ ] No rate limiting

---

## 7. Virtual Card Vulnerabilities

- [ ] Mass Assignment in card limit updates
- [ ] Mass Assignment in card funding exchange-rate handling
- [ ] Predictable card number generation
- [ ] Plaintext storage of card details
- [ ] No validation on card limits
- [ ] BOLA in card operations
- [ ] Race conditions in balance updates
- [ ] Card detail information disclosure
- [ ] No transaction verification
- [ ] Lack of card activity monitoring
- [ ] Client-controlled currency conversion during card funding

---

## 8. Bill Payment Vulnerabilities

- [ ] No validation on payment amounts
- [ ] SQL injection in biller queries
- [ ] Information disclosure in payment history
- [ ] Predictable reference numbers
- [ ] Transaction history exposure
- [ ] No validation on biller accounts
- [ ] Race conditions in payment processing
- [ ] BOLA in payment history access
- [ ] Missing payment limits

---

## 9. AI Customer Support Vulnerabilities

- [ ] Prompt Injection (CWE-77)
- [ ] AI-based Information Disclosure (CWE-200)
- [ ] Broken Authorization in AI context (CWE-862)
- [ ] AI System Information Exposure (CWE-209)
- [ ] Insufficient Input Validation for AI prompts (CWE-20)
- [ ] Direct Database Access through AI manipulation
- [ ] AI Role Override attacks
- [ ] Context Injection vulnerabilities
- [ ] AI-assisted unauthorized data access
- [ ] Exposed AI system prompts and configurations

---

## 10. GraphQL Vulnerabilities

- [ ] Enabled schema introspection on the transaction analytics endpoint
- [ ] Weak JWT-based authentication inherited by /graphql
- [ ] SQL injection in GraphQL resolver query construction
- [ ] Missing GraphQL depth / complexity controls
- [ ] Raw GraphQL error disclosure
- [ ] Transaction analytics exposure through admin-scoped queries
